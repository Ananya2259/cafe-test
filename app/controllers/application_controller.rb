class ApplicationController < ActionController::Base
  before_filter :ensure_user_logged_in
  before_filter :routes_manager


  def routes_manager
    if ["/edit_profile", "/main_menu"].include?(request.path) && current_user.role == "Admin"
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
    if ["/users", "/menu_categories"].include?(request.path) && current_user.role == "user"
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
    if ["/edit_profile", "/menu_categories", "/users"].include?(request.path) && current_user.role == "clerk"
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def current_user #memoization
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
