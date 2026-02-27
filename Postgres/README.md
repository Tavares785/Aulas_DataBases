# 🚀 PostgreSQL com Docker Compose

Este projeto configura o PostgreSQL usando Docker Compose, construindo a imagem localmente a partir de um Dockerfile.

---

## 🧑‍💻 Como usar

### 1. Certifique-se de que o arquivo `docker-compose.yml` e o `Dockerfile` estejam na pasta `Postgres`.

Conteúdo do `docker-compose.yml`:

```yaml
version: '3.8'

services:
  db:
    build: .
    container_name: postgres_loja
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: loja_virtual
    ports:
      - "5432:5432"
    volumes:
      - ./init-db:/docker-entrypoint-initdb.d
    restart: always
```

### 2. Suba o container

No diretório `Postgres`, execute:
```bash
docker-compose up -d
```

### 3. Conecte-se ao PostgreSQL

Você pode conectar-se via ferramentas como DBeaver, PgAdmin ou `psql` local usando:

- **Host:** `localhost`
- **Porta:** `5432`
- **Usuário:** `admin123`
- **Senha:** `admin123`
- **Banco:** `auladb`

---

## ⚙️ Comandos úteis

```bash
docker-compose up -d       # Inicia o container em segundo plano
docker-compose down        # Encerra e remove o container
docker-compose down -v     # Encerra, remove o container e os volumes (reseta o banco)
docker-compose logs -f     # Acompanha os logs em tempo real
docker-compose restart     # Reinicia o serviço
```

---

## 🧪 Teste rápido com SQL

Após conectar-se ao banco `auladb`:

```sql
CREATE TABLE test (id SERIAL PRIMARY KEY, message TEXT);
INSERT INTO test (message) VALUES ('PostgreSQL está funcionando!');
SELECT * FROM test;
```

---

## ✅ Requisitos

- Docker
- Docker Compose

---

🛠 Desenvolvido para fins educacionais e experimentação local.