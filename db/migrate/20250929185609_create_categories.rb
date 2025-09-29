class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :group_title, null: false
      t.string :title, null: false
      t.timestamps
    end
  end
end
