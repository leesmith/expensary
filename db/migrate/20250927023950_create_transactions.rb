class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.text :description, null: false
      t.date :tran_date, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.timestamps
    end
    add_index :transactions, :tran_date
  end
end
