class Auth::SignupsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new user_params
      if @user.invalid? 
        respond_to do |format|
          @errors = @user.errors
          format.js
        end
      elsif @user.save

        redirect_to root_url
      end
      
  end

  private
  def user_params
    params[:user].permit(:name, :phone_number, :email, :password, :password_confirmation)
  end
end
