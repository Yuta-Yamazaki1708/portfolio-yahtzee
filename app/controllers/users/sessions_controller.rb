class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash.notice = "ログインに成功しました。"
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash.notice = "ゲストユーザーでログインしました。"
    redirect_to root_path
  end

  def destroy
    super
    flash.notice = "ログアウトしました。"
  end
end
