class Users::MypageController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to mypage_path(current_user)
    else
      render action: :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :icon)
  end
end
