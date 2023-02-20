class Public::CartItemsController < ApplicationController

  before_action :cart_item, only: [:update, :destroy]
  before_action :authenticate_customer!

  #

  def index
    @cart_items = current_customer.cart_items.all
    @total_price = calculate(current_customer)
    # @item = cart_items.items.find_by(id: 1) カート内で同じ商品があれば個数を増やす find_byを使う
    # byebug
  end

  # カート商品を追加・保存
  def create
      cart_item = current_customer.cart_items.new(cart_item_params)
      
      
      # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
      #ex.バナナ２個、バナナ２個ではなく　バナナ「4個」にしたい
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
                        #元々カート内にあるもの「item_id」
                        #今追加した　　　　　　　params[:cart_item][:item_id])
          cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
          cart_item.amount += params[:cart_item][:amount].to_i
         #cart_item.amountに今追加したparams[:cart_item][:amount]を加える
         #.to_iとして数字として扱う
      end
      cart_item.save
      redirect_to cart_items_path
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
    params.require(:cart_item).permit(:item_id, :amount, :price)
  end

  ## 消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end

  def calculate(user)
    total_price = 0
    user.cart_items.each do |cart_item|
      total_price += cart_item.amount * cart_item.item.price
    end
    return (total_price * 1.1).floor
  end


end
