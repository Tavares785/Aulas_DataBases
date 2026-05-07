# ⚡ Índices: A Chave do Desempenho no MongoDB

Índices bem definidos podem melhorar drasticamente a velocidade das consultas. No MongoDB, é possível indexar desde campos simples até estruturas complexas. 

Abaixo estão exemplos práticos de cada tipo de índice:

---

### 1. Índice Simples
Criado em um único campo. É ideal para filtros diretos e frequentes em campos de alta busca.

*   **Cenário:** Busca rápida por e-mail na coleção de usuários.
*   **Comando:**
```javascript
db.usuarios.createIndex({ email: 1 })
```
*   **Consulta beneficiada:** 
```javascript
db.usuarios.find({ email: "aluno@faculdade.edu" })
```

---

### 2. Índice Composto
Cobre múltiplos campos. A ordem dos campos na criação é fundamental para a eficiência da busca e da ordenação.

*   **Cenário:** Filtrar produtos por categoria e exibir os mais baratos primeiro.
*   **Comando:**
```javascript
db.produtos.createIndex({ categoria: 1, preco: 1 })
```
*   **Consulta beneficiada:** 
```javascript
db.produtos.find({ categoria: "Eletrônicos" }).sort({ preco: 1 })
```

---

### 3. Índice em Array (Multikey Index)
Indexa cada elemento de um array separadamente, habilitando buscas rápidas por valores contidos dentro de listas.

*   **Cenário:** Buscar produtos através de tags (etiquetas) de interesse.
*   **Comando:**
```javascript
db.produtos.createIndex({ tags: 1 })
```
*   **Consulta beneficiada:** 
```javascript
db.produtos.find({ tags: "promoção" })
```

---

### 4. Índice Aninhado (Campos Embutidos)
Indexa campos dentro de objetos embutidos usando a **notação de ponto** (`objeto.campo`).

*   **Cenário:** Localizar clientes por uma cidade específica dentro do objeto de endereço residencial.
*   **Comando:**
```javascript
db.clientes.createIndex({ "endereco.cidade": 1 })
```
*   **Consulta beneficiada:** 
```javascript
db.clientes.find({ "endereco.cidade": "São Paulo" })
```

---
> O comando `.explain("executionStats")` ao final de uma consulta permite comparar o tempo de execução e ver se o MongoDB usou um **IXSCAN** (Varredura de Índice) ou um **COLLSCAN** (Varredura de Coleção Inteira).
```