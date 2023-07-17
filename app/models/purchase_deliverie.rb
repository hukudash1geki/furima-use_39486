class PurchaseDeliverie
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :cities_and_towns, :house_number, :building_name, :telephone_number, :user_id,
                :item_id, :token, :purchase_id

  validates :token, presence: true
  validates :postal_code, presence: true
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :cities_and_towns
    validates :house_number
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :telephone_number, presence: true
  validates :telephone_number, length: { minimum: 11, too_short: 'is too short' }
  validates :telephone_number, numericality: { other_than: 0, message: 'is invalid. Input only number' }

  def save
    purchase = Purchase.create(item_id:, user_id:)
    deliverie = Deliverie.create(postal_code:, prefecture_id:, cities_and_towns:,
                                 house_number:, building_name:, telephone_number:, purchase_id: purchase.id)
  end
end
