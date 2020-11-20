class SessionsController < ApplicationController
  skip_before_action :set_current_user, only: :create

  def create
    @user = User.find_by!(email: email).try(:authenticate, password)
    session[:user_id] = @user.id
    render status: :created
  end

  def logged_in; end

  def logout
    reset_session
    render status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def email
    user_params[:email]
  end

  def password
    user_params[:password]
  end
end
