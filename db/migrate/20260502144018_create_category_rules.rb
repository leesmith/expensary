class CreateCategoryRules < ActiveRecord::Migration[8.1]
  def change
    create_table :category_rules do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :amount
      t.references :category, foreign_key: true, null: false
      t.timestamps
    end
  end
end
