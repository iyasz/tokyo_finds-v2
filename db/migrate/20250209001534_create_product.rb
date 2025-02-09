class CreateProduct < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :price
      t.string :stock
      t.references :series, null: true, foreign_key: true
      t.references :character, null: true, foreign_key: true
      t.references :brand, null: true, foreign_key: true
      t.string :weight
      t.text :description
      t.string :slug

      t.integer :status
      t.string :release
      t.string :estimated_arrival
      t.string :down_payment
      t.string :full_payment_discount

      t.timestamps
    end
  end
end
