# 🚀 PostgreSQL com Docker Compose

Este projeto configura o PostgreSQL usando Docker Compose, construindo a imagem localmente a partir de um Dockerfile.

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