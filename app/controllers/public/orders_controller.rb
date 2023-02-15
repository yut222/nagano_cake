class Public::OrdersController < ApplicationController

  before_action :to_log, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @orders = current_customer.orders.all
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  def confirm
  end

  def thanks
  end

  def index
  end

  def show
  end
end
