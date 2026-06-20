# Parte 1: Modelagem de Dados
1. Incorporação (Embedding)

```bash
    {
  "_id": 1,
  "nome": "Curso de MongoDB",
  "categoria": "Banco de Dados",
  "modulos": [
    {
      "nome": "Introdução ao MongoDB",
      "carga_horaria": 5
    },
    {
      "nome": "Consultas e Filtros",
      "carga_horaria": 8
    },
    {
      "nome": "Aggregation Framework",
      "carga_horaria": 10
    }
  ]
}

 
Colocar os módulos dentro do documento do curso melhora o desempenho de leitura porque todas as informações ficam armazenadas em um único documento. Assim, o MongoDB consegue buscar o curso e seus módulos em apenas uma consulta, sem precisar acessar outra coleção.


2. Referência (Reference)
Documento do Instrutor

{
  "_id": 101,
  "nome": "Carlos Silva",
  "especialidade": "Banco de Dados"
}

{
  "_id": 1,
  "nome": "Curso de MongoDB",
  "instrutor_id": 101
}

Referenciar o instrutor é melhor quando o mesmo instrutor ministra vários cursos. Assim, os dados dele ficam armazenados apenas uma vez, evitando duplicação e facilitando atualizações.

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

Parte 3: Aggregation Framework

Pipeline de agregação:

db.vendas.aggregate([
  {
    $match: {
      status: "concluída"
    }
  },
  {
    $group: {
      _id: "$categoria",
      total_quantidade: {
        $sum: "$quantidade"
      }
    }
  }
])