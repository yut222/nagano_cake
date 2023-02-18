class Public::OrdersController < ApplicationController

  before_action :to_log, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  #情報入力画面でボタンを押して情報をsessionに保存

# 購入を確定します
def create # Order に情報を保存します
  cart_items = current_customer.cart_items.all
# ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
  @order = current_customer.orders.new(order_params)
# 渡ってきた値を @order に入れます
  if @order.save
# ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    cart_items.each do |cart|
# 取り出したカートアイテムの数繰り返します
# order_detail にも一緒にデータを保存する必要があるのでここで保存します
      order_detail = OrderDetail.new
      order_detail.item_id = cart.item.id
      order_detail.price = cart.item.price
      order_detail.order_id = @order.id
      order_detail.amount = cart.amount
# 購入が完了したらカート情報は削除するのでこちらに保存します
      order_detail.price = cart.item.price
# カート情報を削除するので item との紐付けが切れる前に保存します
      order_detail.save
    end
    cart_items.destroy_all    # 購入後はカート内商品削除
    redirect_to orders_thanks_path

# ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
  else
    render :new
  end
end

  # 購入確認画面
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.shipping_cost = 800  # 送料

  if params[:order][:selected_address] == "1"
    @order.postal_code = current_customer.postal_code
    @order.address     = current_customer.address
    @order.name        = current_customer.last_name + current_customer.first_name

  elsif params[:order][:selected_address] == "2"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

#   birding.pry

# viewに記述(each,商品合計,請求金額)
#    @sum = 0
#    @subtotals = @cart_items.map { |cart_item| (Item.find(cart_item.item_id).price * 1.1 * cart_item.amount).to_i }
#    @sum = @subtotals.sum
#    session[:sum] = @sum

  end


  def thanks


  end

  def index

  end

  def show
  end

    private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :payment_method, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end

end
