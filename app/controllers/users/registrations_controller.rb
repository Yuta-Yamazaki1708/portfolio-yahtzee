# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :ensure_guest_user, only: [:update_profile, :update, :destroy]
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

  def show_profile
  end

  def edit_profile
  end

  def update_profile
    if current_user.update(profile_params)
      flash.now.notice = "プロフィールを更新しました。"
      render "update_profile"
    else
      render action: :edit_profile, status: :unprocessable_entity
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

  def profile_params
    params.require(:user).permit(:username, :icon)
  end

  def account_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      flash.now.alert = "ゲストユーザーは編集、退会ができません。"
      render "ensure_guest_user", formats: :turbo_stream
    end
  end
end
