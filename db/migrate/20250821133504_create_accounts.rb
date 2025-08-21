class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :description
      t.integer :account_type, default: 0, null: false
      t.decimal :balance, precision: 12, scale: 2
      t.timestamps
    end
    add_index :accounts, :account_type
  end
end
