class Public::CartItemsController < ApplicationController

  before_action :cart_item, only: [:update, :destroy]
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total_price = calculate(current_customer)
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id


    if @cart_item.save!  # ビックリマークとつけるとエラーがそこで止まってくれる
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      flash[:alert] = "個数を選択してください"
      render "index"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_back(fallback_location: root_path)
  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount, :order_id, :praice, :making_status)
  end

  def calculate(user)
    total_price = 0
    user.cart_items.each do |cart_item|
      total_price += cart_item.amount * cart_item.item.price
    end
    return (total_price * 1.1).floor
  end
end
