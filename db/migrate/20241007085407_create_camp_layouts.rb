class CreateCampLayouts < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_layouts do |t|
      t.integer :post_id,        null: false
      t.text    :description,    null: false
      t.text    :recommendation, null: false
      t.timestamps
    end
  end
end
