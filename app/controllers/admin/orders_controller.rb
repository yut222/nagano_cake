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

  def orders_update
    @order = Order.find(params[:order][:id])
    if @order.update(params_int(order_params))
      flash[:success] = "注文ステータスを更新しました"
      status_is_deposited?(@order)
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = "注文ステータスの更新に失敗しました"
      redirect_to admin_order_detail_path(@order)
    end
  end

  def order_details_update
    @order_details = OrderDetails.find(params[:making_status][:id])
    if @order_details.update(params_int(order_details_params))
      flash[:info] = "製作ステータスを更新しました"
      making_status_is_in_production?(@order_details)
      @order = Order.find_by(id: params[:order_details][:order_id])
      order_details_is_production_complete?(@order)
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = "製作ステータスの更新に失敗しました"
      redirect_to admin_order_detail_path(@order)
    end
  end



    private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_details_params
    params.require(:order_details).permit(:making_status)
  end

end
