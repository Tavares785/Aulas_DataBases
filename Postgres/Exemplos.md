# Explorando o Banco de Dados PostgreSQL

Vamos criar as queries para a tabela `aula`.

**Pré-requisito:** Assumimos que você já conectou ao banco de dados onde a tabela `aula` será criada.

## Criando a Tabela (Opcional)

```sql
CREATE TABLE aula (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    cidade VARCHAR(100),
    profissao VARCHAR(100)
);
```

## Inserindo Dados

**Vamos inserir alguns registros de exemplo na tabela `aula`:**
```sql
INSERT INTO aula (nome, idade, cidade, profissao) VALUES
('Ana Clara', 28, 'São Paulo', 'Cientista de Dados'),
('Carlos Alberto', 42, 'Belo Horizonte', 'Engenheiro de Software'),
('Mariana Oliveira', 30, 'Rio de Janeiro', 'Desenvolvedora Front-end'),
('Lucas Santos', 25, 'São Paulo', 'Analista de Sistemas'),
('Fernanda Pereira', 38, 'Curitiba', 'Gerente de Projetos');

-- Verificando a inserção
SELECT * FROM aula;
```

## Consultar por Idade Superior a um Valor

**Vamos consultar todos os registros na tabela aula onde a idade é superior a 30 anos:**
```sql
SELECT * FROM aula WHERE idade > 30;
```

## Atualizar a Profissão

**Vamos atualizar a profissão de "Pedro Souza" para "Engenheiro de Dados":**
```sql
UPDATE aula
SET profissao = 'Engenheiro de Dados'
WHERE nome = 'Pedro Souza';

-- Verificando a atualização
SELECT * FROM aula WHERE nome = 'Pedro Souza';
```

## Remover por Cidade

**Vamos remover todos os registros da tabela aula onde a cidade é "Belo Horizonte":**
```sql
DELETE FROM aula WHERE cidade = 'Belo Horizonte';

-- Verificando a remoção
SELECT * FROM aula;
```

## Criar Índice

**Vamos criar um índice no campo "profissao":**
```sql
CREATE INDEX idx_aula_profissao ON aula(profissao);

-- Visualizando os índices (comando psql)
-- \d aula
```

## Consultar com Múltiplos Critérios e Projeção

**Vamos encontrar todos os registros onde a idade seja menor que 35 E a cidade seja "São Paulo", exibindo apenas os campos "nome" e "profissao":**
```sql
SELECT nome, profissao
FROM aula
WHERE idade < 35 AND cidade = 'São Paulo';
```

## Outros Exemplos de Consultas

**Consultar por igualdade (profissão):**
```sql
SELECT * FROM aula WHERE profissao = 'Analista de Sistemas';
```

**Consultar com diferença (cidade diferente):**
```sql
SELECT * FROM aula WHERE cidade <> 'São Paulo';
```

**Consultar com OR (idade ou profissão):**
```sql
SELECT * FROM aula
WHERE idade < 30 OR profissao = 'Gerente de Projetos';
```

**Limitar resultados:**
```sql
SELECT * FROM aula LIMIT 2;
```

**Ordenar por nome (ascendente):**
```sql
SELECT * FROM aula ORDER BY nome ASC;
```

**Ordenar por idade (descendente):**
```sql
SELECT * FROM aula ORDER BY idade DESC;
```

**Atualizar múltiplos registros (incrementar idade):**
```sql
UPDATE aula
SET idade = idade + 1
WHERE profissao = 'Analista de Sistemas';
```

**Remover um registro específico (por nome):**
```sql
DELETE FROM aula WHERE nome = 'Carlos Alberto';
```