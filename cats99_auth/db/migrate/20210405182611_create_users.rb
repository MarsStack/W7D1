class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name, unique: true, null: false
      t.string :password_digest, null: false
      t.string :session_token, unique: true, null: false


      t.timestamps
    end

    add_index :users, :user_name
    add_index :users, :session_token
  end
end
