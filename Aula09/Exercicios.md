### Proposta de Aula Pratica

**Objetivo:** Compreender a flexibilidade do modelo de documentos e praticar operacoes CRUD essenciais utilizando o `mongosh`.

**Cenario:** Vamos construir um sistema simplificado de **Catalogo de E-commerce**, onde os alunos experimentarao a criacao de produtos com atributos variados, aproveitando o esquema flexivel do MongoDB.

---

### Catalogo de Dados de Referencia

Os alunos podem usar os exemplos abaixo como base para montar a colecao `produtos`.

#### Colecao: `produtos`

Cada documento representa um produto da loja virtual. Apesar de estarem na mesma colecao, os documentos podem ter campos diferentes de acordo com a categoria.

#### Exemplo 1: Smartphone

```javascript
{
  nome: "Smartphone Galaxy A15",
  categoria: "Eletronicos",
  preco: 1299.90,
  marca: "Samsung",
  armazenamento: "128GB",
  cor: "Azul"
}
```

#### Exemplo 2: Livro

```javascript
{
  nome: "MongoDB na Pratica",
  categoria: "Livros",
  preco: 79.90,
  autor: "Joao Silva",
  editora: "Tech Books",
  paginas: 320
}
```

#### Exemplo 3: Camiseta

```javascript
{
  nome: "Camiseta Basica",
  categoria: "Roupas",
  preco: 49.90,
  tamanho: "M",
  cor: "Preta",
  material: "Algodao"
}
```

#### Exemplo 4: Notebook

```javascript
{
  nome: "Notebook Ultra X",
  categoria: "Eletronicos",
  preco: 3899.90,
  marca: "Lenovo",
  memoria_ram: "16GB",
  processador: "Intel i7"
}
```

#### Exemplo 5: Tenis

```javascript
{
  nome: "Tenis Runner Pro",
  categoria: "Calcados",
  preco: 299.90,
  tamanho: 42,
  cor: "Branco",
  marca: "Olympikus"
}
```

#### Observacao sobre o modelo

No MongoDB, documentos da mesma colecao nao precisam ter exatamente os mesmos campos. Essa flexibilidade permite que produtos de categorias diferentes fiquem armazenados juntos sem a obrigacao de um esquema fixo.

---

### Parte 1: Exercicios Praticos

#### Exercicio 1: Criacao e Colecoes (O "C" do CRUD)

1. Crie um banco de dados chamado `loja_virtual`.
2. Crie a colecao `produtos`.
3. Insira um produto simples, como o smartphone, usando `insertOne()`.
4. Insira pelo menos dois outros produtos de categorias diferentes usando `insertMany()`.

Dica: voce pode usar como referencia os documentos do catalogo de dados acima.

#### Exercicio 2: Consultas e Filtros (O "R" do CRUD)

1. Liste todos os produtos da colecao.
2. Busque apenas produtos onde o preco seja superior a `100`.
3. Liste apenas os produtos da categoria `Eletronicos`.
4. Realize uma busca que retorne apenas o `nome` e o `preco` dos produtos.

#### Exercicio 3: Atualizacao Dinamica (O "U" do CRUD)

1. Atualize o preco de um produto especifico usando o operador `$set`.
2. Adicione um novo campo chamado `estoque` para todos os produtos usando `updateMany()`.
3. Marque os produtos da categoria `Roupas` com o campo `promocao: true`.

#### Exercicio 4: Exclusao de Dados (O "D" do CRUD)

1. Remova um produto especifico usando `deleteOne()`.
2. Remova todos os produtos de uma categoria usando `deleteMany()`.

### ENTREGA: 
1. Faça um fork do Repositorio ou crie um seu
2. Faça tudo o que foi pedido e coloque em um resposta.md
3. Me envie o link pelo Forms: https://docs.google.com/forms/d/e/1FAIpQLSfTlyfskwsJ1nE4haBaUtZkwet5EpE3S0KNu4ZVg52fsbSuTA/viewform?usp=header