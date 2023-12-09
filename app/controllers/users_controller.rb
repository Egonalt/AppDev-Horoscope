class UsersController < ApplicationController

  def new
    @user = User.new
  
  end
  def stocks
    @user = User.find(params[:id])
    all_tickers = @user.user_stocks.pluck(:stock_tickers).join(',').split(',')
    @unique_tickers = all_tickers.uniq  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to astro_home_path, notice: 'Account created successfully'
    else
      render :new
    end
  end  


  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
