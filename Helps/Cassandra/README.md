# Cassandra com Docker Compose

Este material mostra como subir o Apache Cassandra com Docker Compose e acessar o banco pelo `cqlsh`.

## O que está incluído

- Cassandra em container Docker
- Porta padrão exposta:
  - `9042`
- Volume persistente para os dados
- Cluster local configurado com:
  - cluster: `AulaCluster`
  - datacenter: `datacenter1`
  - rack: `rack1`

## Como subir o ambiente

No diretório `Helps/Cassandra`, execute:

```bash
docker-compose up -d
```

Para verificar se o container está rodando:

```bash
docker-compose ps
docker-compose logs -f
```

O Cassandra pode levar alguns minutos para inicializar completamente. Aguarde os logs indicarem que o serviço está pronto antes de acessar pelo `cqlsh`.

Para parar o ambiente:

```bash
docker-compose down
```

Para parar e remover também o volume de dados:

```bash
docker-compose down -v
```

## Como acessar o Cassandra

Você pode se conectar usando o `cqlsh` por dentro do container:

```bash
docker exec -it cassandra_db cqlsh
```

Ou fora do container, no seu teminal, precisa ter o cqlsh:

```bash
cqlsh localhost 9042
```

Se o Cassandra ainda estiver iniciando, o comando pode falhar. Nesse caso, aguarde mais alguns segundos e tente novamente.

## Comandos principais no Cassandra

Depois de entrar no `cqlsh`, os comandos mais usados são:

```sql
DESCRIBE KEYSPACES;
DESCRIBE CLUSTER;
SHOW VERSION;
```

## Criando um keyspace e uma tabela

Exemplo para criar um keyspace chamado `auladb`:

```sql
CREATE KEYSPACE IF NOT EXISTS auladb
WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};
```

Selecione o keyspace:

```sql
USE auladb;
```

Crie uma tabela de pessoas:

```sql
CREATE TABLE IF NOT EXISTS pessoas (
  id UUID PRIMARY KEY,
  nome TEXT,
  idade INT,
  cidade TEXT,
  profissao TEXT
);
```

## Inserindo e consultando dados

```sql
INSERT INTO pessoas (id, nome, idade, cidade, profissao)
VALUES (uuid(), 'Carlos', 30, 'Campinas', 'Desenvolvedor');

INSERT INTO pessoas (id, nome, idade, cidade, profissao)
VALUES (uuid(), 'Maria', 25, 'São Paulo', 'Designer');

SELECT * FROM pessoas;
```

## Atualizando e removendo dados

No Cassandra, atualizações e remoções devem usar a chave primária:

```sql
UPDATE pessoas
SET cidade = 'Atibaia'
WHERE id = <uuid_do_registro>;

DELETE FROM pessoas
WHERE id = <uuid_do_registro>;
```

Para facilitar testes de atualização e remoção, você pode criar um registro com UUID fixo:

```sql
INSERT INTO pessoas (id, nome, idade, cidade, profissao)
VALUES (11111111-1111-1111-1111-111111111111, 'João', 32, 'Jundiaí', 'Analista');

UPDATE pessoas
SET cidade = 'Atibaia'
WHERE id = 11111111-1111-1111-1111-111111111111;

DELETE FROM pessoas
WHERE id = 11111111-1111-1111-1111-111111111111;
```

## Conferindo a estrutura

```sql
DESCRIBE KEYSPACE auladb;
DESCRIBE TABLE auladb.pessoas;
SELECT * FROM auladb.pessoas;
```

## Requisitos

- Docker
- Docker Compose

Material preparado para uso local em aula e testes.
