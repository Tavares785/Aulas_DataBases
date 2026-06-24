import os
import psycopg2
import time
from datetime import datetime

def connect_db():
    """Conecta ao banco PostgreSQL"""
    return psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "localhost"),
        port=int(os.getenv("POSTGRES_PORT", "5432")),
        database=os.getenv("POSTGRES_DB", "oltp_db"),
        user=os.getenv("POSTGRES_USER", "cdc_user"),
        password=os.getenv("POSTGRES_PASSWORD", "cdc_pass")
    )

def test_create():
    """Testa criação de dados"""
    conn = connect_db()
    cursor = conn.cursor()

    try:
        # Gera um sufixo único usando o timestamp atual
        ts = int(time.time())
        # Create user
        cursor.execute(
            "INSERT INTO users (name, email) VALUES (%s, %s) RETURNING id;",
            (f"Novo Usuário {ts}", f"novo_{ts}@example.com")
        )
        user_id = cursor.fetchone()[0]
        conn.commit()
        print(f"✓ Usuário criado com ID: {user_id}")

        # Create order
        cursor.execute(
            "INSERT INTO orders (user_id, total, status) VALUES (%s, %s, %s) RETURNING id;",
            (user_id, 1500.00, 'pending')
        )
        order_id = cursor.fetchone()[0]
        conn.commit()
        print(f"✓ Pedido criado com ID: {order_id}")
        return user_id, order_id

    finally:
        cursor.close()
        conn.close()

def test_update(order_id):
    """Testa atualização de dados"""
    conn = connect_db()
    cursor = conn.cursor()

    try:
        cursor.execute(
            "UPDATE orders SET status = %s, updated_at = %s WHERE id = %s;",
            ('shipped', datetime.now(), order_id)
        )
        conn.commit()
        print(f"✓ Pedido {order_id} atualizado: status = 'shipped'")

    finally:
        cursor.close()
        conn.close()

def test_delete(user_id):
    """Testa deleção de dados"""
    conn = connect_db()
    cursor = conn.cursor()

    try:
        # Remove pedidos associados primeiro para evitar erro de Foreign Key
        cursor.execute("DELETE FROM orders WHERE user_id = %s;", (user_id,))
        # Agora remove o usuário
        cursor.execute("DELETE FROM users WHERE id = %s;", (user_id,))
        conn.commit()
        print(f"✓ Usuário {user_id} e seus pedidos deletados")

    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    print("=" * 50)
    print("Teste CDC - PostgreSQL to Kafka to Redis")
    print("=" * 50)

    print("\n[1] Testando CREATE...")
    time.sleep(1)
    u_id, o_id = test_create()

    print("\n[2] Testando UPDATE...")
    time.sleep(2)
    test_update(o_id)

    print("\n[3] Testando DELETE...")
    time.sleep(2)
    test_delete(u_id)

    print("\n" + "=" * 50)
    print("Testes finalizados com sucesso!")