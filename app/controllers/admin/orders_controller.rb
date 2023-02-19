class Admin::OrdersController < ApplicationController

  # ログインユーザーのみに表示
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all

    # 下記３行は商品合計を出すため
    @sum = 0
    @subtotals = @order_details.map { |order_detail| order_detail.price * order_detail.amount }
    @sum = @subtotals.sum
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "注文ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = "注文ステータスの更新に失敗しました"
      redirect_to admin_order_detail_path(@order)
    end
  end


    private

  def order_params
    params.require(:order).permit(:shipping_cost, :total_payment, :name, :payment_method, :address, :postal_code, :status)
  end


end