class CreateAddress < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name
      t.string :telp, limit: 20
      t.string :province
      t.string :province_id
      t.string :city
      t.string :city_id
      t.text :street
      t.string :zipcode
      t.boolean :is_main, default: false

      t.timestamps
    end
  end
end
