# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_guest_user, only: [:update, :destroy]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def create
    super do |resource|
      resource.icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.jpg')), filename: 'icon.jpg')
    end
    if resource.save
      flash.notice = "新規登録が完了しました。"
    end
  end

  def update
    super
    if current_user.update(account_params)
      flash.notice = "アカウント設定を更新しました。"
    end
  end

  def destroy
    super
    flash.notice = "退会が完了しました。"
  end

  private

  def account_params
    params.require(:user).permit(:email, :password)
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
