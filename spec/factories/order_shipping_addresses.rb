FactoryBot.define do
  factory :order_shipping_address do
    post_code { '123-4567' }
    shipping_area_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    tel_number {  '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end