class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_date
      t.string :username
      t.string :password
      t.string :email

    end
  end

  def down
    drop_table :users
  end
end
