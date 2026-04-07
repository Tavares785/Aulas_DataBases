# Use a imagem oficial do MongoDB como base
# FROM mongo:latest
# FROM mongo:6.0

# Exponha a porta padrão do MongoDB
# EXPOSE 27017

# Defina o usuário para executar o processo do MongoDB (boa prática de segurança)
# USER mongodb

# Comando para iniciar o servidor MongoDB
# CMD ["mongod", "--bind_ip", "0.0.0.0"]

# Usa a imagem oficial do MongoDB como base
FROM mongo:6.0

# Exponha a porta padrão do MongoDB
EXPOSE 27017

# Define variáveis de ambiente para criar usuário e banco
ENV MONGO_INITDB_ROOT_USERNAME=admin
ENV MONGO_INITDB_ROOT_PASSWORD=admin123
ENV MONGO_INITDB_DATABASE=testdb

# Copia script de inicialização para o diretório usado pelo MongoDB
COPY init-data.js /docker-entrypoint-initdb.d/
