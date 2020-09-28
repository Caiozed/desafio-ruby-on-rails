class Transaction < ApplicationRecord
  has_one :transaction_type, class_name: 'TransactionType', primary_key: 'tipo', foreign_key: 'id'
end
