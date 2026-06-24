#!/bin/bash

# Wait for Debezium Connect to be ready
until curl -s http://localhost:8083/connectors; do
  echo 'Waiting for Debezium Connect...'
  sleep 2
done

echo "Debezium is ready. Registering PostgreSQL connector..."

# Register PostgreSQL connector
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d '{
    "name": "postgres-cdc-connector",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "database.hostname": "postgres",
      "database.port": 5432,
      "database.user": "cdc_user",
      "database.password": "cdc_pass",
      "database.dbname": "oltp_db",
      "database.server.name": "postgres",
      "publication.name": "cdc_publication",
      "slot.name": "debezium_slot",
      "plugin.name": "pgoutput",
      "table.include.list": "public.users,public.orders,public.products",
      "topic.prefix": "cdc"
    }
  }'

echo "Connector registered successfully!"
