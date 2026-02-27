# 🚀 MongoDB com Docker Compose

Este projeto configura o MongoDB usando Docker Compose, com armazenamento persistente via volumes Docker.

---

## 📦 O que está incluído

- MongoDB (última versão estável)
- Volume persistente para os dados: `/data/db`
- Usuário root `admin123` criado
- Acesso via `mongosh` e outras ferramentas de banco de dados

---

## 🧑‍💻 Como usar

### 1. Crie o arquivo `docker-compose.yml` na pasta `MongoDB` com o seguinte conteúdo:

```yaml
version: '3.8'

services:
  mongo:
    image: mongo:latest
    container_name: mongo_db
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin123
      MONGO_INITDB_ROOT_PASSWORD: admin123
    volumes:
      - mongo_data:/data/db

volumes:
  mongo_data:
```

### 2. Suba o container

No diretório `MongoDB`, execute:
```bash
docker-compose up -d
```

### 3. Conecte-se ao MongoDB

Você pode conectar-se via ferramentas como MongoDB Compass ou `mongosh` usando a seguinte string de conexão:

```
mongodb://admin123:admin123@localhost:27017/
```

Ao conectar, você pode usar qualquer nome de banco de dados, por exemplo `auladb`, e ele será criado automaticamente no primeiro uso.

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

## 🧪 Teste rápido com `mongosh`

Após conectar-se ao servidor:

```javascript
use auladb; // Seleciona ou cria o banco de dados
db.test.insertOne({ message: "MongoDB está funcionando!" });
db.test.find();
```

---

## ✅ Requisitos

- Docker
- Docker Compose

---

🛠 Desenvolvido para fins educacionais e experimentação local.