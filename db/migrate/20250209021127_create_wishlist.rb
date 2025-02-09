class CreateWishlist < ActiveRecord::Migration[8.0]
  def change
    create_table :wishlists do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
