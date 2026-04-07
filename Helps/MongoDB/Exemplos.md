# Explorando o Banco de Dados MongoDB

Vamos criar as queries para a coleção `aula`

**Pré-requisito:** Assumimos que você já conectou o `mongosh` ao seu servidor MongoDB e selecionou o banco de dados onde a coleção `aula` será criada ou já existe.

## Inserindo Dados

**Vamos inserir alguns documentos de exemplo na coleção `aula`:**
```javascript
db.aula.insertOne({
  "nome": "Ana Clara",
  "idade": 28,
  "cidade": "São Paulo",
  "profissao": "Cientista de Dados"
});

db.aula.insertOne({
  "nome": "Carlos Alberto",
  "idade": 42,
  "cidade": "Belo Horizonte",
  "profissao": "Engenheiro de Software"
});

db.aula.insertOne({
  "nome": "Mariana Oliveira",
  "idade": 30,
  "cidade": "Rio de Janeiro",
  "profissao": "Desenvolvedora Front-end"
});

db.aula.insertOne({
  "nome": "Lucas Santos",
  "idade": 25,
  "cidade": "São Paulo",
  "profissao": "Analista de Sistemas"
});

db.aula.insertOne({
  "nome": "Fernanda Pereira",
  "idade": 38,
  "cidade": "Curitiba",
  "profissao": "Gerente de Projetos"
});

// Verificando a inserção
db.aula.find();
```

## Consultar por Idade Superior a um Valor

**Vamos consultar todos os registros na coleção aula onde a idade é superior a 30 anos:**
```JavaScript
db.aula.find({ "idade": { "$gt": 30 } });
```

## Atualizar a Profissão

**Vamos atualizar a profissão de "Pedro Souza" para "Engenheiro de Dados":**
```Javascript
db.aula.updateOne(
  { "nome": "Pedro Souza" },
  { "$set": { "profissao": "Engenheiro de Dados" } }
);

// Verificando a atualização
db.aula.find({ "nome": "Pedro Souza" });
```

## Remover por Cidade

**Vamos remover todos os registros da coleção aula onde a cidade é "Belo Horizonte":**
```javascript
db.aula.deleteMany({ "cidade": "Belo Horizonte" });

// Verificando a remoção
db.aula.find();
```

## Criar Índice

**Vamos criar um índice no campo "profissao":**
```JavaScript
db.aula.createIndex({ "profissao": 1 });

// Visualizando os índices da coleção "aula"
db.aula.getIndexes();
```

## Consultar com Múltiplos Critérios e Projeção

**Vamos encontrar todos os registros onde a idade seja menor que 35 E a cidade seja "São Paulo", exibindo apenas os campos "nome" e "profissao":**
```JavaScript
db.aula.find(
  {
    "$and": [
      { "idade": { "$lt": 35 } },
      { "cidade": "São Paulo" }
    ]
  },
  { "nome": 1, "profissao": 1, "_id": 0 } // 1 para incluir, 0 para excluir o _id
);
```

## Outros Exemplos de Consultas

**Consultar por igualdade (profissão):**
```JavaScript
db.aula.find({ "profissao": "Analista de Sistemas" });
```

**Consultar com $ne (cidade diferente):**
```JavaScript
db.aula.find({ "cidade": { "$ne": "São Paulo" } });
```

**Consultar com $or (idade ou profissão):**
```JavaScript
db.aula.find({
  "$or": [
    { "idade": { "$lt": 30 } },
    { "profissao": "Gerente de Projetos" }
  ]
});
```

**Limitar resultados:**
```JavaScript
db.aula.find().limit(2);
```

**Ordenar por nome (ascendente):**
```JavaScript
db.aula.find().sort({ "nome": 1 });
```

**Ordenar por idade (descendente):**
```JavaScript
db.aula.find().sort({ "idade": -1 });
```

**Atualizar múltiplos registros (incrementar idade):**
```JavaScript
db.aula.updateMany(
  { "profissao": "Analista de Sistemas" },
  { "$inc": { "idade": 1 } }
);
```

**Remover um registro específico (por nome):**
```JavaScript
db.aula.deleteOne({ "nome": "Carlos Alberto" });
```