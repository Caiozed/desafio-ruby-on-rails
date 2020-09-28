# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
transaction_types = [
  [1, 'Débito', 'Entrada', '+'],
  [2, 'Boleto', 'Saída', '-'],
  [3, 'Financiamento', 'Saída', '-'],
  [4, 'Crédito', 'Entrada', '+'],
  [5, 'Recebimento Empréstimo', 'Entrada', '+'],
  [6, 'Vendas', 'Entrada', '+'],
  [7, 'Recebimento TED', 'Entrada', '+'],
  [8, 'Recebimento DOC', 'Entrada', '+'],
  [9, 'Aluguel', 'Saída', '-']
]

if TransactionType.first.nil?
  transaction_types.each do |id, descricao, natureza, sinal|
    TransactionType.create(id: id, descricao: descricao, natureza: natureza, sinal: sinal)
  end
end
