class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :tipo
      t.datetime :data
      t.float :valor
      t.string :cpf
      t.string :cartao
      t.string :dono
      t.string :loja

      t.timestamps
    end
  end
end
