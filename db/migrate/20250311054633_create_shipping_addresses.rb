class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.string :post_code,         null: false
      t.integer :shipping_area_id, null: false
      t.string :city,              null: false
      t.string :address,           null: false
      t.string :building_name
      t.string :tel_number,        null: false
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
