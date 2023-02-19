class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])

    @order_detail.update(order_detail_params)
    @order = @order_detail.order



		case order_detail.making_status
		 when "製作中"
				order_detail.order.update(order_status: "making")
		 when "製作完了"
			if order_detail.order.order_details.all?{|order_detail| order_detail.making_status == "make_done"}
				order_detail.order.update(order_status: "delivery")  # 発送準備中
			end
		end
		redirect_to admins_order_path(order_detail.order.id)
  end

    private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :making_status, :amount, :item_id, :price)
  end
end