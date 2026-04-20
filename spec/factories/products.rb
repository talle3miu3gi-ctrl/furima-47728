FactoryBot.define do
  factory :product do
    name { "テスト商品" }
    description { "テストの説明文です" }
    category_id { 2 }
    product_status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    delivery_schedule_id { 2 }
    price { 500 }
    association :user

     after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
