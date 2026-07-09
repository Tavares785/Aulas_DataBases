## Respostas ##

## Parte: 1 ##
1. é melhor pois junta todas as informações em um só arquivo, isso consume menos recursos pois reduz o número de buscas e facilita o número de operações (cálculos) a serem realizadas durante essas buscas.

2. Seria melhor em situações em que o instrutor ministra vários cursos, os dados podem mudar com frequência etc.

## Parte: 2 ##
1. db.clientes.find({
  email: { $exists: true }
})

2. db.clientes.find({
  idade: { $gte: 21 }
})

3. Da seguinte forma:
db.clientes.find({
  cidade: "São Paulo",
  idade: { $lt: 30 }
})

## Parte: 3 ##
R:
db.vendas.aggregate([
  {
    $match: {
      status: "concluída"
    }
  },
  {
    $group: {
      _id: "$categoria",
      totalQuantidadeVendida: {
        $sum: "$quantidade"
      }
    }
  }
])



1. Filtra apenas os documentos com:
status: "concluída"

2. Agrupa os documentos pelo campo:
categoria

3. Soma os valores do campo:
quantidade

Neste caso, esperamos a saída:
    [
    {
        _id: "Periféricos",
        totalQuantidadeVendida: 15
    },
    {
        _id: "Informática",
        totalQuantidadeVendida: 8
    }
    ]