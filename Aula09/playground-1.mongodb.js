// selecionar banco
use('loja_virtual')

// ==========================
// CREATE
// ==========================

// inserir um produto
db.produtos.insertOne({
  nome: "Smartphone Galaxy A15",
  categoria: "Eletronicos",
  preco: 1299.90,
  marca: "Samsung",
  armazenamento: "128GB",
  cor: "Azul"
})

// inserir vários
db.produtos.insertMany([
  {
    nome: "MongoDB na Pratica",
    categoria: "Livros",
    preco: 79.90,
    autor: "Joao Silva",
    editora: "Tech Books",
    paginas: 320
  },
  {
    nome: "Camiseta Basica",
    categoria: "Roupas",
    preco: 49.90,
    tamanho: "M",
    cor: "Preta",
    material: "Algodao"
  }
])


// ==========================
// READ
// ==========================

// listar tudo
db.produtos.find()

// preco > 100
db.produtos.find({ preco: { $gt: 100 } })

// categoria Eletronicos
db.produtos.find({ categoria: "Eletronicos" })

// apenas nome e preco
db.produtos.find({}, { nome: 1, preco: 1, _id: 0 })


// ==========================
// UPDATE
// ==========================

// atualizar preco
db.produtos.updateOne(
  { nome: "Smartphone Galaxy A15" },
  { $set: { preco: 1199.90 } }
)

// adicionar estoque
db.produtos.updateMany(
  {},
  { $set: { estoque: 100 } }
)

// marcar promocao
db.produtos.updateMany(
  { categoria: "Roupas" },
  { $set: { promocao: true } }
)


// ==========================
// DELETE
// ==========================

// deletar um
db.produtos.deleteOne({ nome: "MongoDB na Pratica" })

// deletar categoria
db.produtos.deleteMany({ categoria: "Calcados" })