class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :genre
      t.string :isbn
      t.integer :author_id

      t.timestamps
    end
  end
end
