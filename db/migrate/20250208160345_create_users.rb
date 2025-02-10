class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :gender, limit: 1
      t.string :telp, limit: 20
      t.integer :roles, limit: 1

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
