# Redis com Docker Compose

Este material mostra como subir o Redis com Docker Compose, acessar o banco pelo `redis-cli` e usar a interface web do RedisInsight.

## O que está incluído

- Redis 7 em container Docker
- RedisInsight para acesso visual pelo navegador
- Volume persistente para os dados
- AOF habilitado com `appendonly yes`
- Portas expostas:
  - Redis: `6379`
  - RedisInsight: `5540`

## Como subir o ambiente

No diretório `Helps/Redis`, execute:

```bash
docker-compose up -d
```

Para verificar se os containers estão rodando:

```bash
docker-compose ps
docker-compose logs -f
```

Para parar o ambiente:

```bash
docker-compose down
```

Para parar e remover também o volume de dados:

```bash
docker-compose down -v
```

## Como acessar o Redis pelo terminal

Você pode se conectar usando o `redis-cli` por dentro do container:

```bash
docker exec -it redis redis-cli
```

Ou, se você tiver o `redis-cli` instalado na sua máquina:

```bash
redis-cli -h localhost -p 6379
```

## Como acessar pelo RedisInsight

Acesse no navegador:

```text
http://localhost:5540
```

Ao criar a conexão no RedisInsight, use:

- Host: `redis`
- Porta: `6379`
- Usuário: deixe em branco
- Senha: deixe em branco

Se estiver conectando por uma ferramenta fora do Docker, use:

- Host: `localhost`
- Porta: `6379`

## Comandos principais no Redis

Depois de entrar no `redis-cli`, alguns comandos úteis são:

```redis
PING
SET nome "Carlos"
GET nome
DEL nome
EXISTS nome
KEYS *
FLUSHDB
```

## Trabalhando com listas

```redis
LPUSH tarefas "Estudar Redis"
LPUSH tarefas "Criar exemplos"
RPUSH tarefas "Revisar comandos"
LRANGE tarefas 0 -1
LPOP tarefas
RPOP tarefas
```

## Trabalhando com hashes

```redis
HSET pessoa:1 nome "Maria" idade 25 cidade "São Paulo"
HGET pessoa:1 nome
HGETALL pessoa:1
HSET pessoa:1 profissao "Designer"
HDEL pessoa:1 cidade
```

## Trabalhando com sets

```redis
SADD linguagens "SQL" "Python" "Java"
SADD linguagens "Python"
SMEMBERS linguagens
SISMEMBER linguagens "Python"
SREM linguagens "Java"
```

## Trabalhando com expiração

```redis
SET sessao:1 "usuario-logado"
EXPIRE sessao:1 60
TTL sessao:1
GET sessao:1
```

## Conferindo persistência

Como o Redis está usando volume e AOF, os dados permanecem após reiniciar o container:

```bash
docker-compose restart redis
```

Depois, acesse novamente o `redis-cli` e consulte uma chave criada anteriormente:

```redis
GET nome
```

## Requisitos

- Docker
- Docker Compose

Material preparado para uso local em aula e testes.
