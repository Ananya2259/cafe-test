class Api::V1::OrdersController < Api::V1::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :ensure_user_logged_in

  def index
    if @condition
      orders = Order.where(@condition)
    else 
      orders = Order.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?      
    end
    render json: orders.as_json(only: [:status, :address])
  end

  def create
    if @build_params.kind_of?(Hash)
      if @item.save
        render json: @item 
      else
         render json: @item.errors, status: :unprocessable_entity 
      end
    else
      render plain: @build_params
    end
  end

  def update
    @item.update_attributes(order_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def show
    render json: @item.as_json(:status, :user_id, :address)
  end

  def update_order_status
    order_details_update =  !params[:from_date].nil? && !params[:to_date].nil? ? {"status" => {from_date: params[:from_date],to_date: params[:to_date]}}  : {"archive" => {}}
    ArchiveWorker.perform_async(order_details_update)
    render status: 200,json: {message: "working"}
  end

  def order_params
    if !params[:from_date].nil? and !params[:to_date].nil?
        update_order_status()
    else
       params[:action] == "create" ? params[cname].permit(:status,:user_id,:address) : params[:cname].permit(:status)
    end
  end

end