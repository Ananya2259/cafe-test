class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :ensure_user_logged_in
  skip_before_filter :routes_manager, only: [:create]
 
  def show
    render json: @item.as_json(only: [:name, :email])
  end

  def index
     if @condition
       condition = @condition.split(",");
       users = User.where(@condition)
     else 
       users = User.all.limit(@limit).offset(@offset * @limit) unless @offset.blank?      
     end
     render json: users.as_json(only: [:name, :email])   
  end

  def create
    if @item.save
      render json: @item
      head :no_content
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    respond_to do |format|
      @item.destroy
      format.json { head :no_content }
    end
  end

  def update
    @item.update_attributes(user_params)
    render status: 200, json: {
      message: "update sucessfull",
    }
  end

  def user_params
    params[:action] == "create" ? params[cname].permit(:name, :email, :password, :role) : params[cname].permit(:name, :email)
  end

end
