#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Detectar executável do Python (prioriza o virtualenv local)
if [ -f "$SCRIPT_DIR/.venv/bin/python3" ]; then
    PYTHON="$SCRIPT_DIR/.venv/bin/python3"
else
    PYTHON="python3"
fi

help() {
    cat << EOF
${BLUE}CDC Lab - Change Data Capture${NC}

Uso: $0 [comando]

Comandos:
  ${GREEN}setup${NC}           Configura o ambiente Python (Virtualenv) e dependências
  ${GREEN}start${NC}           Inicia todos os serviços (docker-compose up)
  ${GREEN}stop${NC}            Para todos os serviços (docker-compose down)
  ${GREEN}logs${NC}            Mostra logs de todos os serviços
  ${GREEN}ps${NC}              Lista containers
  ${GREEN}test${NC}            Executa testes CDC
  ${GREEN}consumer${NC}        Inicia o consumer Kafka
  ${GREEN}postgres${NC}        Acessa terminal do PostgreSQL
  ${GREEN}redis${NC}           Acessa CLI do Redis
  ${GREEN}kafka${NC}           Lista tópicos Kafka
  ${GREEN}status${NC}          Verifica status do Debezium
  ${GREEN}help${NC}            Mostra esta mensagem

Exemplos:
  $0 start
  $0 logs
  $0 test
EOF
}

setup() {
    echo -e "${BLUE}🛠️ Configurando ambiente local...${NC}"
    if [ ! -d "$SCRIPT_DIR/.venv" ]; then
        python3 -m venv "$SCRIPT_DIR/.venv"
        echo -e "${GREEN}✓ Virtualenv criado${NC}"
    fi
    
    echo -e "${YELLOW}📦 Instalando dependências...${NC}"
    "$PYTHON" -m pip install --upgrade pip
    "$PYTHON" -m pip install redis kafka-python-ng psycopg2-binary
    echo -e "${GREEN}✓ Dependências instaladas${NC}"
}

start() {
    echo -e "${BLUE}🚀 Iniciando serviços...${NC}"
    docker compose up -d
    echo -e "${GREEN}✓ Serviços iniciados${NC}"

    echo -e "${YELLOW}⏳ Aguardando serviços estabilizarem (5s)...${NC}"
    sleep 5

    echo -e "${YELLOW}⏳ Configurando conector Debezium...${NC}"
    
    # Localiza o ID do container do Debezium de forma resiliente
    DEBEZIUM_ID=$(docker ps -q -f name=debezium_cdc)
    if [ -n "$DEBEZIUM_ID" ]; then
        docker exec -u root "$DEBEZIUM_ID" /bin/bash /debezium-init.sh
    else
        echo -e "${RED}❌ Erro: Container debezium_cdc não encontrado.${NC}"
    fi

    echo -e "${GREEN}✓ Configuração concluída!${NC}"
}

stop() {
    echo -e "${BLUE}🛑 Parando serviços...${NC}"
    docker compose down
    echo -e "${GREEN}✓ Serviços parados${NC}"
}

logs() {
    docker compose logs -f "$@"
}

ps() {
    docker compose ps
}

test() {
    echo -e "${BLUE}🧪 Executando testes CDC...${NC}"
    $PYTHON "$SCRIPT_DIR/test_cdc.py"
}

consumer() {
    echo -e "${BLUE}🔄 Iniciando Consumer Kafka...${NC}"
    echo -e "${YELLOW}(Pressione Ctrl+C para parar)${NC}"
    $PYTHON "$SCRIPT_DIR/kafka_consumer.py"
}

postgres() {
    echo -e "${BLUE}🐘 Acessando PostgreSQL...${NC}"
    local cid=$(docker ps -q -f name=postgres_oltp)
    if [ -z "$cid" ]; then
        echo -e "${RED}❌ Erro: Container postgres_oltp não encontrado.${NC}"
        return 1
    fi
    docker exec -it "$cid" psql -U cdc_user -d oltp_db
}

redis() {
    echo -e "${BLUE}💾 Acessando Redis CLI...${NC}"
    local cid=$(docker ps -q -f name=redis_cache)
    if [ -z "$cid" ]; then
        echo -e "${RED}❌ Erro: Container redis_cache não encontrado.${NC}"
        return 1
    fi
    docker exec -it "$cid" redis-cli
}

kafka() {
    echo -e "${BLUE}📨 Tópicos Kafka:${NC}"
    local cid=$(docker ps -q -f name=kafka_broker)
    if [ -z "$cid" ]; then
        echo -e "${RED}❌ Erro: Container kafka_broker não encontrado.${NC}"
        return 1
    fi
    docker exec "$cid" kafka-topics --bootstrap-server localhost:9092 --list
}

status() {
    echo -e "${BLUE}📊 Status Debezium:${NC}"
    curl -s http://localhost:8083/connectors/postgres-cdc-connector/status | jq '.' || echo "Conector não encontrado"
}

case "${1:-help}" in
    setup)      setup ;;
    start)      start ;;
    stop)       stop ;;
    logs)       logs "${@:2}" ;;
    ps)         ps ;;
    test)       test ;;
    consumer)   consumer ;;
    postgres)   postgres ;;
    redis)      redis ;;
    kafka)      kafka ;;
    status)     status ;;
    help|*)     help ;;
esac
