class CreateBookInstances < ActiveRecord::Migration
  def change
    create_table :book_instances do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
