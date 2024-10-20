class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.integer :camp_meal_id, null: false
      t.string  :ingredient,   null: false
      t.string  :amount,       null: false
      t.timestamps
    end
  end
end
