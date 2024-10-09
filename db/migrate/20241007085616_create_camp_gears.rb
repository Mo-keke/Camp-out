class CreateCampGears < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_gears do |t|
      t.integer :camp_layout_id, null: false
      t.string  :name,           null: false
      t.text    :description,    null: false
      t.timestamps
    end
  end
end