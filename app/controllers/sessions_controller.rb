class SessionsController < ApplicationController
  before_action :check_if_login, only: [:destroy]
  before_action :current_user

  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to recite_tasks_url, :notice => "login success"
    else
      @user = User.new()
      @user.email = params[:user][:email]
      flash[:notice] = "email or password wrong, plesase check"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => "logout success"
  end

end
