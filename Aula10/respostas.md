# Exercício Prático: Modelagem e Consultas em MongoDB

## Parte 1: Modelagem de Dados

### 1. Incorporação (Embedding)

```js
db.cursos.insertOne({
  nome: "Curso de MongoDB",
  categoria: "Banco de Dados",
  carga_total: 40,
  modulos: [
    {
      nome: "Introdução ao MongoDB",
      carga_horaria: 10
    },
    {
      nome: "CRUD no MongoDB",
      carga_horaria: 15
    },
    {
      nome: "Aggregation Framework",
      carga_horaria: 15
    }
  ]
})
Pergunta:

Colocar os módulos dentro do documento do curso melhora o desempenho de leitura porque todas as informações necessárias ficam armazenadas em um único documento. Assim, o MongoDB consegue retornar o curso e seus módulos em apenas uma consulta, sem precisar buscar dados em outra coleção.

2. Referência (Reference)
Documento Instrutor
db.instrutores.insertOne({
  _id: 1,
  nome: "Carlos Silva",
  especialidade: "Banco de Dados"
})
Documento Curso
db.cursos.insertOne({
  nome: "MongoDB Avançado",
  categoria: "Banco de Dados",
  instrutor_id: 1
})
Pergunta:

Referenciar o instrutor é melhor quando o mesmo instrutor ministra vários cursos. Dessa forma, os dados do instrutor ficam centralizados em apenas um documento, evitando duplicação de informações e facilitando atualizações futuras.

Parte 2: Consultas e Filtros
1. Filtro de Existência
db.clientes.find({
  email: { $exists: true }
})
2. Filtro de Comparação
db.clientes.find({
  idade: { $gte: 21 }
})
3. Filtro Complexo
db.clientes.find({
  cidade: "São Paulo",
  idade: { $lt: 30 }
})
Parte 3: Aggregation Framework (Relatórios)
Pipeline de Agregação
db.vendas.aggregate([
  {
    $match: {
      status: "concluída"
    }
  },
  {
    $group: {
      _id: "$categoria",
      total_quantidade_vendida: {
        $sum: "$quantidade"
      }
    }
  }
])