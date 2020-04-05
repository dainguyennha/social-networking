class ProductsController < ApplicationController
  before_action :logged_in_user
  def index

    
  end
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to new_auth_session_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless @user == current_user
  end


end
