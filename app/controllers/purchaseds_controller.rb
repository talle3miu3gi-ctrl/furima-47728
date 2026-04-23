class PurchasedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :check_access


  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchased_address = PurchasedAddress.new
  end

  def create
      @purchased_address = PurchasedAddress.new(purchase_params)
    if @purchased_address.valid?
      pay_item
      @purchased_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
      params.require(:purchased_address).permit(:zip_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, product_id: params[:product_id], token: params[:token])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
       amount: @product.price,
       card: @purchased_address.token,
       currency: 'jpy'
    )
end
   def check_access
     if current_user.id == @product.user_id || @product.purchased.present?
      redirect_to root_path
    end
  end
end