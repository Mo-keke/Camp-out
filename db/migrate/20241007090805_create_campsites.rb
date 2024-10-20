class CreateCampsites < ActiveRecord::Migration[6.1]
  def change
    create_table :campsites do |t|
      t.integer :post_id,     null: false
      t.string  :name,        null: false
      t.text    :description, null: false
      t.string  :address,     null: false
      t.float   :review,      null: false
      t.timestamps
    end
  end
end
