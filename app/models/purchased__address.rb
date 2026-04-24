class PurchasedAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :zip_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
    validates :token 
  end

  def save
    return false if invalid?
    purchased = Purchased.create(user_id: user_id, product_id: product_id)
    Address.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, purchased_id: purchased.id)
  end
end