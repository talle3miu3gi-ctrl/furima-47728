class Product < ApplicationRecord
    belongs_to :user
    has_one    :purchased
    has_one_attached :image
end
