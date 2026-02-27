db = db.getSiblingDB('testdb');

db.entregas.insertMany([
  {
    entregaId: 1,
    clienteId: 'C001',
      
    destino: 'Rio de Janeiro',
    status: 'em trânsito',
    coleta: new Date('2025-06-01T08:00:00Z'),
    entrega: null
  },
  {
    entregaId: 2,
    clienteId: 'C002',
    origem: 'Belo Horizonte',
    destino: 'Brasília',
    status: 'entregue',
    coleta: new Date('2025-05-30T09:00:00Z'),
    entrega: new Date('2025-06-01T14:00:00Z')
  }
]);
