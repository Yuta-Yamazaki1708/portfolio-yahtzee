class Users::MypageController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to mypage_path(@user)
    else
      render action: :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :icon)
  end
end
