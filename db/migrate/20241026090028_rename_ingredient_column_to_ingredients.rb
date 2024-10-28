class RenameIngredientColumnToIngredients < ActiveRecord::Migration[6.1]
  def change
    rename_column :ingredients, :ingredient, :name
  end
end
