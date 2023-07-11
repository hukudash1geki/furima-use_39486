class Deliverie < ApplicationRecord
  belongs_to :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :prefecture

    with_options presence: true do
      validates :postal_code
      validates :cities_and_towns
      validates :house_number
      validates :telephone_number
    end

  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  validates :telephone_number, length: { minimum: 11, too_short: "is too short" }
  validates :telephone_number, format: { without:  /\A\d+\z/, message: "is invalid. Input only number" }

  
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :prefecture_id
  end
end
