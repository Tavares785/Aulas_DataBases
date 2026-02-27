# 🚀 Neo4j com Docker Compose

Este projeto configura o Neo4j usando Docker Compose, com suporte aos plugins **APOC** e **n10s**, e armazenamento persistente via volumes Docker.

---

## 📦 O que está incluído

- Neo4j 5 (última versão estável)
- Plugins:
  - [APOC](https://neo4j.com/developer/neo4j-apoc/)
  - [n10s](https://neo4j.com/labs/neosemantics/) (RDF, Linked Data)
- Volumes persistentes: `/data`, `/logs`, `/plugins`
- Configurações de memória e page cache
- Acesso via navegador e Bolt protocol

---

## 🧑‍💻 Como usar

### 1. Crie o arquivo `docker-compose.yml` com o seguinte conteúdo:

```yaml
version: '3.8'

services:
  neo4j:
    image: neo4j:5
    container_name: neo4j
    ports:
      - 7474:7474   # Interface web (Neo4j Browser)
      - 7687:7687   # Bolt protocol
    environment:
      - NEO4J_AUTH=neo4j/senha123
      - NEO4J_dbms_memory_heap_initial__size=512M
      - NEO4J_dbms_memory_heap_max__size=1G
      - NEO4J_dbms_memory_pagecache_size=512M
      - NEO4JLABS_PLUGINS=["apoc", "n10s"]
      - NEO4J_apoc_export_file_enabled=true
      - NEO4J_apoc_import_file_enabled=true
      - NEO4J_apoc_import_file_use__neo4j__config=true
    volumes:
      - neo4j_data:/data
      - neo4j_logs:/logs
      - neo4j_plugins:/plugins

volumes:
  neo4j_data:
  neo4j_logs:
  neo4j_plugins:
```

### 2. Suba o container

```bash
docker-compose up -d
```

### 3. Acesse o Neo4j

- 🔗 Acesse: [http://localhost:7474](http://localhost:7474)
- 👤 Usuário: `neo4j`
- 🔒 Senha: `senha123` (ou altere no `docker-compose.yml`)

---

## ⚙️ Comandos úteis

```bash
docker-compose up -d       # Inicia o container em segundo plano
docker-compose down        # Encerra e remove o container
docker-compose logs -f     # Acompanha os logs em tempo real
docker-compose restart     # Reinicia o serviço
```

---

## 📁 Volumes

- `neo4j_data`: Armazena os dados do banco
- `neo4j_logs`: Logs do servidor
- `neo4j_plugins`: Plugins adicionais (como APOC)

Esses volumes garantem persistência mesmo após reinicializações.

---

## 🧪 Teste rápido com Cypher

Após acessar o Neo4j Browser:

```cypher
CREATE (a:Person {name: 'Ana'})-[:FRIENDS_WITH]->(b:Person {name: 'Bruno'})
RETURN a, b
```

---

## 📚 Recursos úteis

- Documentação oficial: [neo4j.com/docs](https://neo4j.com/docs/)
- Cypher tutorial: [Neo4j Cypher Manual](https://neo4j.com/docs/cypher-manual/)
- APOC functions: [APOC Reference](https://neo4j.com/labs/apoc/)

---

## ✅ Requisitos

- Docker
- Docker Compose
- Acesso à internet (para baixar a imagem)

---

## 📌 Notas

- Para produção, configure autenticação segura e backup dos volumes.
- Para importar/exportar arquivos, monte volumes adicionais apontando para o diretório desejado do host.

---

🛠 Desenvolvido para fins educacionais e experimentação local.
