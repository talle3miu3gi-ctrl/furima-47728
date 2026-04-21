class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  #has_one    :purchased
  has_one_attached :image

  belongs_to :category
  belongs_to :product_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_schedule

  validates :image, :name, :description, :price, presence: true

  validates :category_id, :product_status_id, :shipping_fee_id, :prefecture_id, :delivery_schedule_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'is out of setting range'
  }
end
