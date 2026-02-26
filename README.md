# Aulas_DataBases

Este repositório contém exemplos de configuração e uso para diferentes bancos de dados, utilizando Docker e Docker Compose para facilitar o setup do ambiente de desenvolvimento.

---

## 🗂️ Estrutura do Projeto

Cada banco de dados possui sua própria pasta, contendo:

- `README.md`: Instruções detalhadas para subir o ambiente com Docker Compose.
- `Exemplos.md`: Exemplos de queries básicas (CRUD, indexação, etc.).
- `docker-compose.yml`: Arquivo de configuração para o Docker.

---

## 💾 Bancos de Dados Disponíveis

Navegue até a pasta do banco de dados de seu interesse para ver as instruções específicas de setup e uso.

- 🐘 **[PostgreSQL](./Postgres/)** - Um poderoso banco de dados relacional open-source.
- 🐬 **[MySQL](./Mysql/)** - O banco de dados relacional open-source mais popular do mundo.
- 🍃 **[MongoDB](./MongoDB/)** - Um banco de dados NoSQL orientado a documentos.
- 🕸️ **[Neo4j](./Neo4j/)** - Um banco de dados de grafos líder de mercado.

## 🧼 Resetando o ambiente

Para resetar completamente o ambiente de um banco de dados específico (incluindo os dados), navegue até a pasta correspondente e execute:

```bash
docker-compose down -v
```

---

## 📚 Conexão Externa

Você pode conectar-se ao PostgreSQL via ferramentas como DBeaver, PgAdmin ou psql local usando:

- **Host:** `localhost`
- **Porta:** `5432`
- **Usuário:** `admin123`
- **Senha:** `admin123`
- **Banco:** `auladb`