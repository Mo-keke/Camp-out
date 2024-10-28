class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.integer :user_id
      t.string  :title,   null: false
      t.string  :email
      t.text    :content, null: false
      t.timestamps
    end
  end
end
