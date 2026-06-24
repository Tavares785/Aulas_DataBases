// ===== PARTE 1 — MODELAGEM =====

// 1A. Embedding — curso com módulos incorporados
db.cursos.insertOne({
  "_id": "curso_001",
  "titulo": "Desenvolvimento Web com Node.js",
  "carga_horaria_total": 40,
  "modulos": [
    { "nome": "Introdução ao Node.js",     "carga_horaria": 6  },
    { "nome": "Express e APIs REST",        "carga_horaria": 10 },
    { "nome": "Autenticação com JWT",       "carga_horaria": 8  },
    { "nome": "Banco de Dados com MongoDB", "carga_horaria": 10 },
    { "nome": "Deploy na Nuvem",            "carga_horaria": 6  }
  ]
})

// 1B. Reference — instrutor separado do curso
db.instrutores.insertOne({
  "_id": "instrutor_001",
  "nome": "Ana Souza",
  "email": "ana.souza@cursos.com",
  "bio": "Desenvolvedora full-stack com 10 anos de experiência"
})

db.cursos.insertOne({
  "_id": "curso_002",
  "titulo": "React do Zero ao Avançado",
  "instrutor_id": "instrutor_001",
  "carga_horaria_total": 32
})

// ===== PARTE 2 — CONSULTAS =====

// Filtro 1 — clientes com email preenchido
db.clientes.find({ email: { $exists: true } })

// Filtro 2 — clientes com idade >= 21
db.clientes.find({ idade: { $gte: 21 } })

// Filtro 3 — São Paulo E idade < 30
db.clientes.find({ "endereco.cidade": "São Paulo", idade: { $lt: 30 } })

// ===== PARTE 3 — AGGREGATION =====

db.vendas.aggregate([
  { $match: { status: "concluída" } },
  { $group: { _id: "$categoria", total_quantidade: { $sum: "$quantidade" } } },
  { $sort: { total_quantidade: -1 } }
])
