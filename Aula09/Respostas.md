## Respostas do TF ##

-> Abaixo estão contemplados os comandos para subir o container docker com o mongodb e os comandos sh para executar no terminal do mongodb parar realizar as ações.

## Exercicio 1: Criacao e Colecoes (O "C" do CRUD)

--> Respostas e evidências:
Primeiro, suba o banco via docker compose com os comandos abaixo:
    'docker-compose up -d'

1 - // Criar/usar o banco
use loja_virtual
![exercicios01_passo1](image.png)

2 - // Criar coleção (Mongo cria automaticamente ao inserir, mas pode forçar)
db.createCollection("produtos")
![exercicios01_passo1](image.png)

3 - // Inserir um produto com insertOne()
db.produtos.insertOne({
  nome: "Smartphone Galaxy A15",
  categoria: "Eletronicos",
  preco: 1299.90,
  marca: "Samsung",
  armazenamento: "128GB",
  cor: "Azul"
})
![exercicio02_passo2](image.png)

4 - // Inserir múltiplos produtos com insertMany()
db.produtos.insertMany([
  {
    nome: "Camiseta Básica",
    categoria: "Roupas",
    preco: 49.90,
    marca: "Hering",
    tamanho: "M",
    cor: "Preta"
  },
  {
    nome: "Notebook Inspiron 15",
    categoria: "Informatica",
    preco: 3499.90,
    marca: "Dell",
    memoria_ram: "8GB",
    armazenamento: "512GB SSD"
  }
])
![exercicio01_passo3](image.png)

## Exercicio 2: Consultas e Filtros (O "R" do CRUD)

1 - // Listar os produtos
db.produtos.find()
// Ou:
db.produtos.find().pretty()
![exercicio2_passo01](image.png)

2 - // Para listar os produtos com preços maior que 100:
db.produtos.find({
  preco: { $gt: 100 }
})
![exercicio2_passo02](image.png)

3 - // Procurar produtos na categoria eletronicos:
db.produtos.find({
  categoria: "Eletronicos"
})
![exercicio2_passo3](image.png)

4 - // Retornar apenas nome e preço:
db.produtos.find(
  {},
  {
    _id: 0,
    nome: 1,
    preco: 1
  }
)
![exercicio2_passo4](image.png)


## Exercicio 3: Atualizacao Dinamica (O "U" do CRUD)


1 - // Atualizar o preço:
db.produtos.updateOne(
  { nome: "Smartphone Galaxy A15" },
  {
    $set: {
      preco: 1199.90
    }
  }
)
![exercicio3_passo1](image.png)

2 - Adicionar o campo 'estoque' para todos os produtos:
db.produtos.updateMany(
  {},
  {
    $set: {
      estoque: 100
    }
  }
)
![exercicio3_passo2](image.png)

3 - // Acrescentar uma promoção na categoria Roupas:
db.produtos.updateMany(
  { categoria: "Roupas" },
  {
    $set: {
      promocao: true
    }
  }
)
![exercicio3_passo3](image.png)


## Exercicio 4: Exclusao de Dados (O "D" do CRUD)


1 - // Remover um produto especifico:
db.produtos.deleteOne({
  nome: "Smartphone Galaxy A15"
})
![exercicio4_passo1](image.png)

2 - // Remover produtos de uma categoria especifica:
db.produtos.deleteMany({
  categoria: "Roupas"
})

![exercicio4_passo2](image.png)