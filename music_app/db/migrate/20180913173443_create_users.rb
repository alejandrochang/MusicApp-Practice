class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true # make sure they're unique
    add_index :users, :session_token, unique: true
    # don't want to do password_digest as we dont want to store in db
  end
end
