CREATE CONSTRAINT pessoa_id IF NOT EXISTS
FOR (p:Pessoa)
REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT cidade_nome IF NOT EXISTS
FOR (c:Cidade)
REQUIRE c.nome IS UNIQUE;

CREATE CONSTRAINT area_nome IF NOT EXISTS
FOR (a:Area)
REQUIRE a.nome IS UNIQUE;

WITH
  [
    'Ana', 'Bruno', 'Carla', 'Diego', 'Eduarda',
    'Felipe', 'Gabriela', 'Henrique', 'Isabela', 'Joao',
    'Karen', 'Lucas', 'Mariana', 'Nicolas', 'Olivia',
    'Paulo', 'Quelia', 'Rafael', 'Sofia', 'Tiago'
  ] AS nomes,
  [
    'Silva', 'Santos', 'Oliveira', 'Souza', 'Pereira',
    'Costa', 'Almeida', 'Ferreira', 'Rodrigues', 'Lima'
  ] AS sobrenomes,
  [
    'Campinas', 'Atibaia', 'Jundiai', 'Sao Paulo', 'Braganca Paulista',
    'Valinhos', 'Vinhedo', 'Americana', 'Limeira', 'Piracicaba'
  ] AS cidades,
  [
    'Tecnologia', 'Administracao', 'Marketing', 'Financas', 'Design'
  ] AS areas,
  [
    'Desenvolvedor', 'Analista', 'Gerente', 'Designer', 'Consultor',
    'Professor', 'Vendedor', 'Engenheiro', 'Coordenador', 'Estagiario'
  ] AS profissoes
UNWIND range(1, 100) AS id
MERGE (p:Pessoa {id: id})
SET
  p.nome = nomes[(id - 1) % size(nomes)] + ' ' + sobrenomes[(id - 1) % size(sobrenomes)],
  p.idade = 18 + (id % 43),
  p.email = 'pessoa' + toString(id) + '@unifaat.edu.br',
  p.profissao = profissoes[(id - 1) % size(profissoes)]
MERGE (c:Cidade {nome: cidades[(id - 1) % size(cidades)]})
MERGE (a:Area {nome: areas[(id - 1) % size(areas)]})
MERGE (p)-[:MORA_EM]->(c)
MERGE (p)-[:ATUA_EM]->(a);

MATCH (p1:Pessoa)
WHERE p1.id <= 100
MATCH (p2:Pessoa {id: CASE WHEN p1.id = 100 THEN 1 ELSE p1.id + 1 END})
MERGE (p1)-[:CONHECE]->(p2);

MATCH (p:Pessoa)
WHERE p.id <= 100 AND p.id % 5 = 0
MATCH (mentor:Pessoa {id: p.id - 4})
MERGE (mentor)-[:MENTORA]->(p);
