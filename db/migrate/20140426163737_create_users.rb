class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :city_state_str
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
