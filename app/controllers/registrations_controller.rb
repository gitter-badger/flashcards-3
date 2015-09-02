class RegistrationsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user.email, user_params[:password])
      redirect_to root_path, notice: 'Пользователь успешно создан.'
    else
      flash.now[:alert] = 'Пользователь не создан'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
