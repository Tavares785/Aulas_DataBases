use loja_virtual

db.produtos.insertOne({
  nome: "Smartphone Galaxy A15",
  categoria: "Eletronicos",
  preco: 1299.90,
  marca: "Samsung",
  armazenamento: "128GB",
  cor: "Azul"
})

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

db.produtos.find()

db.produtos.find({ preco: { $gt: 100 } })

db.produtos.find({ categoria: "Eletronicos" })

db.produtos.find({}, { nome: 1, preco: 1, _id: 0 })

db.produtos.updateOne(
  { nome: "Smartphone Galaxy A15" },
  { $set: { preco: 1199.90 } }
)

db.produtos.updateMany(
  {},
  { $set: { estoque: 100 } }
)

db.produtos.updateMany(
  { categoria: "Roupas" },
  { $set: { promocao: true } }
)

db.produtos.deleteOne({ nome: "Camiseta Basica" })

db.produtos.deleteMany({ categoria: "Livros" })