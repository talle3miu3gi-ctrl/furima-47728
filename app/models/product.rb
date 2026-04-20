class Product < ApplicationRecord
    belongs_to :user
    has_one    :purchased
    has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category  
  belongs_to :product_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_schedule

validates :category_id, :product_status_id, :shipping_fee_id, :prefecture_id, :delivery_schedule_id, 
           numericality: { other_than: 1 , message: "can't be blank" }

end

