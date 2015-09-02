class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: 'Успешный вход')
    else
      flash.now[:alert] = 'Неверный email или пароль. Вход не выполнен'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Сессия закрыта'
  end
end
