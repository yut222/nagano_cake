class Admin::HomesController < ApplicationController

  def top
    @params = params[:id]
    @order = Order.where(customer_id: @params).page(params[:page]).per(10).order(created_at: :desc)
    @orders = Order.page(params[:page]).per(10).order(created_at: :desc)
  end

end
