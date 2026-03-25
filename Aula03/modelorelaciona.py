import time

# --- DADOS DO PROFESSOR (As Tabelas do Slide) ---
clientes = {
    "1": "Ana Silva",
    "2": "Bruno Costa"
}

produtos = {
    "10": {"nome": "Sapatilhas", "preco": 80},
    "20": {"nome": "Mochila", "preco": 50}
}

pedidos = [] # Tabela que vai nascer das relações

def linha(): print("-" * 50)

while True:
    linha()
    print("      SISTEMA DE GESTÃO DE DADOS (Modelo Relacional)      ")
    linha()
    print("1. Ver Tabelas (Entidades)")
    print("2. Criar Pedido (Estabelecer Relacionamento)")
    print("3. Ver Relatório (Fazer um 'JOIN' visual)")
    print("4. Sair")
    
    opcao = input("\nEscolha uma opção: ")

    if opcao == "1":
        print("\n[TABELA CLIENTES] -> PK = ID")
        for id_c, nome in clientes.items(): print(f"ID: {id_c} | Nome: {nome}")
        
        print("\n[TABELA PRODUTOS] -> PK = ID")
        for id_p, info in produtos.items(): print(f"ID: {id_p} | Produto: {info['nome']} | Preço: {info['preco']}€")

    elif opcao == "2":
        print("\n--- INICIANDO RELACIONAMENTO ---")
        id_c = input("Digite o ID do Cliente (FK): ")
        
        # TESTE DE INTEGRIDADE REFERENCIAL
        if id_c not in clientes:
            print("❌ ERRO: Esse Cliente não existe no banco! (Violação de Integridade)")
            continue
            
        id_p = input("Digite o ID do Produto (FK): ")
        if id_p not in produtos:
            print("❌ ERRO: Esse Produto não existe no catálogo!")
            continue

        # Se passou nos testes, criamos a "ponte"
        pedidos.append({"id_cliente": id_c, "id_produto": id_p})
        print("✅ SUCESSO: O relacionamento foi gravado na Tabela Pedidos!")

    elif opcao == "3":
        print("\n--- GERANDO RELATÓRIO (Cruzamento de Dados) ---")
        if not pedidos:
            print("A tabela de Pedidos está vazia.")
        else:
            for p in pedidos:
                # O sistema busca o nome e o preço usando apenas os IDs (FKs)
                nome_cli = clientes[p['id_cliente']]
                nome_prod = produtos[p['id_produto']]['nome']
                valor = produtos[p['id_produto']]['preco']
                print(f"O Cliente [{nome_cli}] comprou o item [{nome_prod}] por {valor}€")
        time.sleep(2)

    elif opcao == "4":
        break