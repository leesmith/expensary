class CreateCategoryRules < ActiveRecord::Migration[8.1]
  def change
    create_table :category_rules do |t|
      t.string :description, null: false
      t.decimal :amount, precision: 12, scale: 2
      t.string :amount_operator, null: false, default: "eq"
      t.references :category, foreign_key: true, null: false
      t.timestamps
    end
  end
end
