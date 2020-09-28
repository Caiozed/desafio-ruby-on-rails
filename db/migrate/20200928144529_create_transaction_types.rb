class CreateTransactionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_types do |t|
      t.string :descricao
      t.string :natureza
      t.string :sinal

      t.timestamps
    end
  end
end
