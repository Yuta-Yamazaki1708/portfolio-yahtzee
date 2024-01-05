require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ページ遷移テスト" do
    it "ログイン画面から新規登録画面へ遷移できること" do
      visit new_user_session_path
      click_on "新規登録はこちら"
      expect(current_path).to eq new_user_registration_path
    end

    it "新規登録画面からログイン登録画面へ遷移できること" do
      visit new_user_registration_path
      click_on "ログインはこちら"
      expect(current_path).to eq new_user_session_path
    end
  end
end
