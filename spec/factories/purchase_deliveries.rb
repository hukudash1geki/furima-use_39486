FactoryBot.define do
  factory :purchase_deliverie do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { '123-4567' }
    prefecture_id { 1 }
    cities_and_towns { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { 12312312312 }
    association :item
  end
end