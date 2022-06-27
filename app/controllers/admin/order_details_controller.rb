class Admin::OrderDetailsController < ApplicationController
  def update
    order = order_detail_params[:order_id]
    order_detail = OrderDetail.find(params[:id])
    if order_detail.update(making_status: params[:order_detail][:making_status]) && order_detail.making?
      order.update(making_status: 2)
    else order_detail.completed?
      order.update(making_status: 2)
    end
     redirect_back(fallback_location: root_path)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
