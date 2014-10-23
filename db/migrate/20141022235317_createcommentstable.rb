class Createcommentstable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.string :body

      t.integer :post_id

      t.timestamps
    end
  end
end
