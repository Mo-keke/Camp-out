class CreateCampMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_meals do |t|
      t.integer  :post_id,       null: false
      t.string   :name,          null: false
      t.text     :description,   null: false
      t.text     :recipe,        null: false
      t.integer  :time_required, null: false
      t.timestamps
    end
  end
end
