class Transaction < ApplicationRecord
  has_one :transaction_type, class_name: 'TransactionType', primary_key: 'tipo', foreign_key: 'id'

  def tipo_str
    transaction_type.descricao
  end
end
