require 'rails_helper'

RSpec.describe Product, type: :model do
 before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '出品できないとき' do
      it 'nameが空では出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では出品できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが1では出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end

      it  'product_status_idが1では出品できない' do
        @product.product_status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Product status can't be blank")
      end

      it  'shipping_fee_idが1では出品できない' do
        @product.shipping_fee_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it  'prefecture_idが1では出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end

      it  'delivery_schedule_idが1では出品できない' do
        @product.delivery_schedule_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery schedule can't be blank")
      end

      it  'priceが空では出品できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it  'priceが300円未満では出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is out of setting range")
      end

      it  'priceが9999999円を超えても出品できない' do
        @product.price =  10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is out of setting range")
      end

      it 'priceが半角数値でなければ出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is out of setting range")
      end

      it 'userが紐付いていなければ出品できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("User must exist")
      end
    end
  end
end