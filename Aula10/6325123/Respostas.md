## Parte 1

### 1. Incorporação

Um exemplo de curso com os módulos no mesmo documento:

```javascript
{
  _id: ObjectId("662f1a000000000000000001"),
  nome: "MongoDB básico",
  carga_horaria: 20,
  modulos: [
    {
      nome: "Introdução",
      carga_horaria: 4
    },
    {
      nome: "Consultas",
      carga_horaria: 8
    },
    {
      nome: "Agregação",
      carga_horaria: 8
    }
  ]
}
```

Eu acho que nesse caso faz sentido colocar os módulos dentro do curso, porque os módulos fazem parte dele. Quando for consultar o curso, provavelmente já vai precisar ver os módulos também, então fica mais rápido buscar tudo junto.

### 2. Referência

Instrutor:

```javascript
{
  _id: ObjectId("662f1b000000000000000001"),
  nome: "Carlos Silva",
  email: "carlos@email.com"
}
```

Curso:

```javascript
{
  _id: ObjectId("662f1c000000000000000001"),
  nome: "Banco de Dados NoSQL",
  carga_horaria: 30,
  instrutor_id: ObjectId("662f1b000000000000000001")
}
```

Nesse caso é melhor usar referência quando o professor dá mais de um curso. Se copiar os dados dele em todos os cursos, depois fica ruim para alterar, por exemplo se ele trocar o email.

## Parte 2

### 1. Clientes com email

```javascript
db.clientes.find({
  email: { $exists: true }
})
```

### 2. Clientes com 21 anos ou mais

```javascript
db.clientes.find({
  idade: { $gte: 21 }
})
```

### 3. Clientes de São Paulo com menos de 30 anos

```javascript
db.clientes.find({
  cidade: "São Paulo",
  idade: { $lt: 30 }
})
```

## Parte 3

```javascript
db.vendas.aggregate([
  {
    $match: {
      status: "concluída"
    }
  },
  {
    $group: {
      _id: "$categoria",
      total_quantidade: { $sum: "$quantidade" }
    }
  }
])
```

Aqui primeiro filtra as vendas que foram concluídas. Depois agrupa pela categoria e soma a quantidade vendida de cada uma.
