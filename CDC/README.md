# CDC (Change Data Capture) - Laboratório

Arquitetura completa de captura e replicação de dados em tempo real usando Debezium, Kafka e Redis.

## 🏗️ Arquitetura

```
PostgreSQL (OLTP) 
    ↓ (WAL - Write-Ahead Log)
Debezium (CDC Connector)
    ↓ (Eventos de mudanças)
Apache Kafka (Message Broker)
    ↓ (Tópicos CDC)
Redis (Cache NoSQL)
```

## 📋 Componentes

| Serviço | Tecnologia | Porta | Papel |
|---------|-----------|-------|-------|
| Origem OLTP | PostgreSQL 15 | 5432 | Injeta dados com transações ACID |
| Capturador CDC | Debezium | 8083 | Escuta WAL e gera eventos |
| Message Broker | Apache Kafka | 9092 | Central de tópicos e buffers |
| Destino Cache | Redis | 6379 | Consome eventos e atualiza cache |

## 🚀 Quick Start

### 1. Preparar o Ambiente
Instale as dependências Python no Virtualenv local:
```bash
./lab.sh setup
```

### 2. Iniciar Infraestrutura
Sobe os containers e configura automaticamente o conector Debezium:
```bash
sudo ./lab.sh start
```

### 3. Monitorar Tópicos (Terminal 1)
Observe os eventos chegando no Kafka:
```bash
./lab.sh kafka
# Ou use: watch -n 1 './lab.sh kafka'
```

### 4. Iniciar Consumer e Teste (Terminais 2 e 3)
```bash
# Terminal 2: Inicia o consumer que sincroniza com Redis
./lab.sh consumer

# Terminal 3: Gera dados no PostgreSQL
./lab.sh test
```

## 📊 Verificar dados

### PostgreSQL
```bash
docker exec -it postgres_oltp psql -U cdc_user -d oltp_db

# Dentro do psql:
SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM products;
```

### Redis
```bash
docker exec -it redis_cache redis-cli

# Dentro do redis-cli:
KEYS *
GET users:1
HGETALL orders:*
```

### Kafka
```bash
# Listar tópicos
docker exec kafka_broker kafka-topics --bootstrap-server localhost:9092 --list

# Consumir mensagens
docker exec kafka_broker kafka-console-consumer --bootstrap-server localhost:9092 \
  --topic cdc.public.users --from-beginning
```

## 🔄 Fluxo de Operações

### CREATE (Inserção)
```
User INSERT → PostgreSQL WAL → Debezium → Kafka Topic (cdc.public.users) → Redis SET
```

### UPDATE (Atualização)
```
User UPDATE → PostgreSQL WAL → Debezium → Kafka Topic (cdc.public.users) → Redis SET (sobrescreve)
```

### DELETE (Deleção)
```
User DELETE → PostgreSQL WAL → Debezium → Kafka Topic (cdc.public.users) → Redis DEL
```

## 📝 Estrutura de Mensagens Kafka

Cada evento no Kafka possui:

```json
{
  "before": { "id": 1, "name": "João Silva", "email": "joao@example.com" },
  "after": { "id": 1, "name": "João Silva", "email": "joao@example.com" },
  "source": {
    "version": "2.4.0",
    "connector": "postgresql",
    "name": "postgres",
    "ts_ms": 1234567890,
    "txId": 100,
    "lsn": 123456,
    "xmin": null,
    "table": "users",
    "schema": "public"
  },
  "op": "c",
  "ts_ms": 1234567890,
  "transaction": null
}
```

**Operações (op):**
- `c` = Create (INSERT)
- `u` = Update (UPDATE)
- `d` = Delete (DELETE)
- `r` = Read (snapshot)

## 🛑 Parar os serviços

```bash
docker-compose down
```

Para remover volumes:
```bash
docker-compose down -v
```

## 🐛 Troubleshooting

### Debezium não se conecta ao PostgreSQL
```bash
# Verifique se PostgreSQL está rodando e acessível
docker exec postgres_oltp psql -U cdc_user -d oltp_db -c "SELECT version();"
```

### Kafka sem mensagens
```bash
# Verifique se o conector está ativo
curl http://localhost:8083/connectors/postgres-cdc-connector/status | jq '.connector.state'
```

### Redis vazio
```bash
# Verifique se o consumer está rodando
docker logs <consumer_container>
```

## 📚 Recursos Adicionais

- [Documentação Debezium](https://debezium.io/documentation/)
- [Apache Kafka](https://kafka.apache.org/)
- [PostgreSQL Logical Replication](https://www.postgresql.org/docs/15/logical-replication.html)
- [Redis Documentation](https://redis.io/docs/)
