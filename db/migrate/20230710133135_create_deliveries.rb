class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string     :postal_code,            null: false
      t.integer    :prefecture_id,          null: false
      t.string     :cities_and_towns,       null: false
      t.string     :house_number,           null: false
      t.string     :building_name
      t.string     :telephone_number,       null: false
      t.references :purchase,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
