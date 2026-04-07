# Explorando o Banco de Dados Neo4j

Vamos criar as queries para o nó do tipo `Pessoa` (equivalente à coleção `aula`).

**Pré-requisito:** Assumimos que você já conectou ao Neo4j Browser ou via Bolt.

## Inserindo Dados

**Vamos inserir alguns nós de exemplo:**
```cypher
CREATE (:Pessoa {
  nome: "Ana Clara",
  idade: 28,
  cidade: "São Paulo",
  profissao: "Cientista de Dados"
});

CREATE (:Pessoa {
  nome: "Carlos Alberto",
  idade: 42,
  cidade: "Belo Horizonte",
  profissao: "Engenheiro de Software"
});

CREATE (:Pessoa {
  nome: "Mariana Oliveira",
  idade: 30,
  cidade: "Rio de Janeiro",
  profissao: "Desenvolvedora Front-end"
});

CREATE (:Pessoa {
  nome: "Lucas Santos",
  idade: 25,
  cidade: "São Paulo",
  profissao: "Analista de Sistemas"
});

CREATE (:Pessoa {
  nome: "Fernanda Pereira",
  idade: 38,
  cidade: "Curitiba",
  profissao: "Gerente de Projetos"
});

// Verificando a inserção
MATCH (p:Pessoa) RETURN p;
```

## Consultar por Idade Superior a um Valor

**Vamos consultar todos os nós Pessoa onde a idade é superior a 30 anos:**
```cypher
MATCH (p:Pessoa)
WHERE p.idade > 30
RETURN p;
```

## Atualizar a Profissão

**Vamos atualizar a profissão de "Pedro Souza" para "Engenheiro de Dados":**
```cypher
MATCH (p:Pessoa {nome: "Pedro Souza"})
SET p.profissao = "Engenheiro de Dados"
RETURN p;
```

## Remover por Cidade

**Vamos remover todos os nós onde a cidade é "Belo Horizonte":**
```cypher
MATCH (p:Pessoa {cidade: "Belo Horizonte"})
DELETE p;

// Verificando a remoção
MATCH (p:Pessoa) RETURN p;
```

## Criar Índice

**Vamos criar um índice no campo "profissao":**
```cypher
CREATE INDEX FOR (p:Pessoa) ON (p.profissao);

// Visualizando os índices
SHOW INDEXES;
```

## Consultar com Múltiplos Critérios e Projeção

**Vamos encontrar todos os nós onde a idade seja menor que 35 E a cidade seja "São Paulo", exibindo apenas os campos "nome" e "profissao":**
```cypher
MATCH (p:Pessoa)
WHERE p.idade < 35 AND p.cidade = "São Paulo"
RETURN p.nome, p.profissao;
```

## Outros Exemplos de Consultas

**Consultar por igualdade (profissão):**
```cypher
MATCH (p:Pessoa {profissao: "Analista de Sistemas"})
RETURN p;
```

**Consultar com diferença (cidade diferente):**
```cypher
MATCH (p:Pessoa)
WHERE p.cidade <> "São Paulo"
RETURN p;
```

**Consultar com OR (idade ou profissão):**
```cypher
MATCH (p:Pessoa)
WHERE p.idade < 30 OR p.profissao = "Gerente de Projetos"
RETURN p;
```

**Limitar resultados:**
```cypher
MATCH (p:Pessoa)
RETURN p
LIMIT 2;
```

**Ordenar por nome (ascendente):**
```cypher
MATCH (p:Pessoa)
RETURN p
ORDER BY p.nome ASC;
```

**Ordenar por idade (descendente):**
```cypher
MATCH (p:Pessoa)
RETURN p
ORDER BY p.idade DESC;
```

**Atualizar múltiplos registros (incrementar idade):**
```cypher
MATCH (p:Pessoa {profissao: "Analista de Sistemas"})
SET p.idade = p.idade + 1
RETURN p;
```

**Remover um registro específico (por nome):**
```cypher
MATCH (p:Pessoa {nome: "Carlos Alberto"})
DELETE p;
```