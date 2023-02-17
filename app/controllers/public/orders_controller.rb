class Public::OrdersController < ApplicationController

  before_action :to_log, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @orders = current_customer.orders.all
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  # 購入確認画面
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.shipping_cost = 800  # 送料

# viewに記述(each,商品合計,請求金額)
#    @sum = 0
#    @subtotals = @cart_items.map { |cart_item| (Item.find(cart_item.item_id).price * 1.1 * cart_item.amount).to_i }
#    @sum = @subtotals.sum
#    session[:sum] = @sum
  end


  def thanks
    # 購入後はカート内商品削除
		cart_items.destroy_all
  end

  def index

  end

  def show
  end

    private

  def order_params
    params.require(:order).permit(:id, :customer_id, :postal_code, :address, :name, :shipping_cost, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end

end
