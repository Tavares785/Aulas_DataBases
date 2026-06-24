import json
import os
import redis
from kafka import KafkaConsumer
from typing import Any, Dict

# Conexão com Redis
redis_client = redis.Redis(
    host=os.getenv('REDIS_HOST', 'localhost'),
    port=int(os.getenv('REDIS_PORT', '6379')),
    decode_responses=True
)

# Consumer Kafka
consumer = KafkaConsumer(
    bootstrap_servers=[os.getenv('KAFKA_BROKER', 'localhost:9092')],
    group_id=os.getenv('KAFKA_GROUP_ID', 'cdc-consumer-group'),
    value_deserializer=lambda m: json.loads(m.decode('utf-8')),
    auto_offset_reset='earliest'
)

# Subscribe aos tópicos CDC
topics = ['cdc.public.users', 'cdc.public.orders', 'cdc.public.products']
consumer.subscribe(topics)

print(f"Consumer iniciado, escutando tópicos: {topics}")

def process_message(msg: Dict[str, Any]) -> None:
    """Processa mensagem CDC e atualiza Redis"""
    if msg is None:
        return

    # O Debezium encapsula o evento em um campo 'payload' por padrão
    payload = msg.get('payload')
    if payload is None:
        payload = msg

    source = payload.get('source', {})
    table = source.get('table')
    op = payload.get('op')  # c=create, u=update, d=delete, r=read

    after = payload.get('after')
    before = payload.get('before')

    if op in ('c', 'u', 'r') and after:  # Create, Update ou Read (Snapshot)
        cache_key = f"{table}:{after.get('id')}"
        redis_client.set(cache_key, json.dumps(after), ex=3600)
        print(f"✓ {op.upper()}: {cache_key} sincronizado no Redis")

    elif op == 'd' and before:  # Delete
        cache_key = f"{table}:{before.get('id')}"
        redis_client.delete(cache_key)
        print(f"✗ DELETE: {cache_key} removido do Redis")
    else:
        print(f"ℹ Mensagem ignorada: op={op}, table={table}")

try:
    for message in consumer:
        print(f"📩 Mensagem recebida do tópico: {message.topic}")
        try:
            process_message(message.value)
        except Exception as e:
            print(f"Erro ao processar mensagem: {e}")

except KeyboardInterrupt:
    print("Consumer encerrado")
finally:
    consumer.close()
