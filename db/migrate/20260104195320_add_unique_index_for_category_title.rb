class AddUniqueIndexForCategoryTitle < ActiveRecord::Migration[8.1]
  def up
    add_index :categories, [:group_title, :title], unique: true
  end

  def down
    remove_index :categories, [:group_title, :title]
  end
end
