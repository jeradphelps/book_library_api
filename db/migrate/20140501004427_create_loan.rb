class CreateLoan < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :book_instance_id, null: false
      t.integer :lender_id, null: false
      t.integer :borrower_id, null: false
      t.boolean :approved, null: false, default: false
      t.boolean :returned, null: false, default: false
      t.datetime :requested_at
      t.datetime :lent_at
      t.date :due_on
      t.timestamp :returned_at
    end
  end
end
