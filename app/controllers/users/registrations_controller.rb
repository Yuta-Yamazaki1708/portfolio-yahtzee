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
  end

  def show_profile
  end

  def edit_profile
  end

  def update_profile
    if current_user.update(profile_params)
      redirect_to profile_path(current_user)
    else
      render action: :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :icon)
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to profile_path(current_user)
    end
  end
end
