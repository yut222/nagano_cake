class Public::OrdersController < ApplicationController

  before_action :to_log, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  #情報入力画面でボタンを押して情報をsessionに保存
  def create
    session[:payment_method] = params[:payment_method]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
      session[:address] ="〒" +current_customer.postal_code+current_customer.address+current_customer.last_name+current_customer.first_name
    end
    if session[:address].present? && session[:payment_method].present?
      redirect_to orders_confirm_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end
  end

  # 購入確認画面
  def confirm
    @cart_items = current_customer.cart_items.all

    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @order.shipping_cost = 800  # 送料
    
    
    


#   birding.pry

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
