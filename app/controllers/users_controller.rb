class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :find_current_user, only: [:edit, :update]

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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Профиль был обновлен'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_current_user
    @user = User.find(current_user.id)
  end
end
