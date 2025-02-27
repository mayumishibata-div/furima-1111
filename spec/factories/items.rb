FactoryBot.define do

  factory :item do
    association :user
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_image.png'), 'image/png') }
    item_name { "Sample Item" }
    item_description { "This is a sample item description." }
    item_category_id { 2 }  # 有効なカテゴリIDとする
    item_condition_id { 2 }  # 有効な状態IDとする
    shipping_cost_id { 2 }   # 有効な送料IDとする
    shipping_area_id { 2 }   # 有効な配送料地域IDとする
    delivery_time_id { 2 }    # 有効な配送時間IDとする
    price { Faker::Number.between(from: 300, to: 9999999).to_s } 
  end
end