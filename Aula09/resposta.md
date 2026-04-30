## Parte 1
Codigos usados:

1-
*use loja_virtual*
![](./image/1.png)

2-
*db.createCollection("produtos")*
![](./image/2.png)

3-
 *db.produtos.insertOne({*
 *nome: "Smartphone Galaxy A15",*
 *categoria: "Eletronicos",*
 *preco: 1299.90,*
 *marca: "Samsung"})*
![](./image/3.png)

4-
*db.produtos.insertMany([{*
 *nome: "Camiseta Basica",*
 *categoria: "Roupas",*
 *preco: 49.90*
*},{*
 *nome: "Livro MongoDB",*
 *categoria: "Livros",*
 *preco: 79.90}])*
 ![](./image/4.png)


## Parte 2
Codigos usados:

1-
 *db.produtos.find()*
 ![](./image/5.png)

 2-
 *db.produtos.find({ preco: { $gt: 100 } })*
 ![](./image/6.png)

 3-
 *db.produtos.find({ categoria: "Eletronicos" })*
 ![](./image/7.png)

 4-
 *db.produtos.find({}, { nome: 1, preco: 1, _id: 0 })*
 ![](./image/8.png)

## Parte 3

 1-
 *db.produtos.updateOne(*
 *{ nome: "Camiseta Basica" },*
 *{ $set: { preco: 39.90 } })*
 ![](./image/9.png)

 2-
 *db.produtos.updateMany(*
 *{},*
 *{ $set: { estoque: 50 } })*
 ![](./image/10.png)

 3-
 *db.produtos.updateMany(*
* { categoria: "Roupas" },*
 *{ $set: { promocao: true } })*
 ![](./image/11.png)

## Parte 4

 1-
 *db.produtos.deleteOne({ nome: "Livro MongoDB" })*
 ![](./image/12.png)

 2-
 *db.produtos.deleteMany({ categoria: "Roupas" })*
 ![](./image/14.png)