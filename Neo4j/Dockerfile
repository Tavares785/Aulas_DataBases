# Usa a imagem oficial do Neo4j (versão 5 mais recente)
FROM neo4j:5

# Define variáveis de ambiente padrão (substitua conforme necessário)
ENV NEO4J_AUTH=neo4j/senha123 \
    NEO4J_dbms_memory_pagecache_size=512M \
    NEO4J_dbms_memory_heap_initial__size=512M \
    NEO4J_dbms_memory_heap_max__size=1G \
    NEO4J_apoc_export_file_enabled=true \
    NEO4J_apoc_import_file_enabled=true \
    NEO4J_apoc_import_file_use__neo4j__config=true

# Exponha as portas padrão do Neo4j
EXPOSE 7474 7687

# Comando de entrada padrão já está definido na imagem base
