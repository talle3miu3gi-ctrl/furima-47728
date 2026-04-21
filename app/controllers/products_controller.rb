class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def index
    #@product = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :description, :price, :category_id, :product_status_id, :shipping_fee_id,
                                    :prefecture_id, :delivery_schedule_id).merge(user_id: current_user.id)
  end
end
