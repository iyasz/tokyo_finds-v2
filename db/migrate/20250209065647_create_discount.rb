class CreateDiscount < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts, id: :uuid do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.boolean :status

      t.timestamps
    end
  end
end
