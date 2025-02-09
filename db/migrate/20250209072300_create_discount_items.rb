class CreateDiscountItems < ActiveRecord::Migration[8.0]
  def change
    create_table :discount_items do |t|
      t.references :discount, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.string :original_price
      t.string :discounted_price

      t.timestamps
    end
  end
end
