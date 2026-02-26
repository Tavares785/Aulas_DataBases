# 🚀 MySQL com Docker Compose

Este projeto configura o MySQL usando Docker Compose, com armazenamento persistente via volumes Docker.

---

## 📦 O que está incluído

- MySQL (última versão estável)
- Volume persistente para os dados: `/var/lib/mysql`
- Banco de dados inicial `auladb` e usuário `admin123` criados
- Acesso via `mysql` client e outras ferramentas de banco de dados

---

## 🧑‍💻 Como usar

### 1. Crie o arquivo `docker-compose.yml` na pasta `Mysql` com o seguinte conteúdo:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:latest
    container_name: mysql_db
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: root_password_123
      MYSQL_DATABASE: auladb
      MYSQL_USER: admin123
      MYSQL_PASSWORD: admin123
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

### 2. Suba o container

No diretório `Mysql`, execute:
```bash
docker-compose up -d
```

### 3. Conecte-se ao MySQL

Você pode conectar-se via ferramentas como DBeaver, MySQL Workbench ou `mysql` client usando:

- **Host:** `localhost`
- **Porta:** `3306`
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
CREATE TABLE test (id INT AUTO_INCREMENT PRIMARY KEY, message VARCHAR(255));
INSERT INTO test (message) VALUES ('MySQL está funcionando!');
SELECT * FROM test;
```

---

## ✅ Requisitos

- Docker
- Docker Compose

---

🛠 Desenvolvido para fins educacionais e experimentação local.