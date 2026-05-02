class CreateCategoryRules < ActiveRecord::Migration[8.1]
  def change
    create_table :category_rules do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :amount
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
