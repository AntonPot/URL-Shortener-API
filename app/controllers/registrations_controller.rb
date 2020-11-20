class RegistrationsController < ApplicationController
  skip_before_action :set_current_user

  def create
    @user = User.create!(user_params)
    session[:user_id] = @user.id
    render status: :created
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
