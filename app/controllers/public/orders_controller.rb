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
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    # total_paymentに請求額を入れる billingはhelperで定義
    @order.total_payment = billing(@order)

    # my_addressに1が入っていれば（自宅）
    if params[:order][:my_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = full_name(current_customer)

    # my_addressに2が入っていれば（配送先一覧）
    elsif params[:order][:my_address] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    # my_addressに3が入っていれば(新配送先)
    elsif params[:order][:my_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @ship = "1"

    # 有効かどうかの確認
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def thanks
  end

  def index
  end

  def show
  end

    private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
