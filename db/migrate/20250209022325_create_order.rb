class CreateOrder < ActiveRecord::Migration[8.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.text :address
      t.string :invoice_code
      t.string :order_id
      t.string :weight
      t.string :destination_id
      t.string :courier_id
      t.string :service

      t.integer :order_status
      t.integer :status
      t.string :payment_method
      t.integer :payment_status
      t.string :shipping_method
      t.string :tracking_number
      t.string :shipping_fee

      t.string :amount_paid
      t.string :total_purchase
      t.string :total
      t.text :notes


      t.timestamps
    end
  end
end
