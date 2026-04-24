require 'rails_helper'

RSpec.describe PurchasedAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @purchased_address = FactoryBot.build(:purchased_address, user_id: user.id, product_id: product.id)
  end

  describe '商品購入機能' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchased_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchased_address.building = ''
        expect(@purchased_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @purchased_address.token = nil
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'zip_codeが空では登録できないこと' do
        @purchased_address.zip_code = nil
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Zip code can't be blank")
      end

      it 'prefecture_idを選択していない（id:1）と保存できないこと' do
        @purchased_address.prefecture_id = 1
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では保存できないこと' do
        @purchased_address.city = ''
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空では保存できないこと' do
        @purchased_address.addresses = ''
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'zip_codeにハイフンがないと保存できないこと' do
         @purchased_address.zip_code = '1234567'
         @purchased_address.valid?
         expect(@purchased_address.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it 'phone_numberが空では保存できないこと' do
        @purchased_address.phone_number = ''
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できないこと' do
        @purchased_address.phone_number = '090123456'
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberが12桁以上では保存できないこと' do
        @purchased_address.phone_number = '090123456789'
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberに半角数字以外が含まれている場合は保存できないこと' do
        @purchased_address.phone_number = '090-1234-5678'
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'user_idが紐付いていないと保存できないこと' do
        @purchased_address.user_id = nil
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("User can't be blank")
      end

      it 'product_idが紐付いていないと保存できないこと' do
        @purchased_address.product_id = nil
        @purchased_address.valid?
        expect(@purchased_address.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end
