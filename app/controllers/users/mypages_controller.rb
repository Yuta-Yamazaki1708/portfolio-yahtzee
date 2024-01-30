class Users::MypagesController < ApplicationController
  before_action :only_signed_in_user, only: [:edit]
  before_action :ensure_guest_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @results = @user.games
    @number_of_play = @user.games.count
    @max_point = @results.maximum(:sum)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      flash.now.notice = "プロフィールを更新しました。"
      render "update_profile", formats: :turbo_stream
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :icon)
  end

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      flash.now.alert = "ゲストユーザーは編集、退会ができません。"
      render "ensure_guest_user", formats: :turbo_stream
    end
  end

  def only_signed_in_user
    unless user_signed_in?
      redirect_to new_user_session_path
      flash.alert = "ログインもしくはアカウント登録してください。"
    end
  end
end
