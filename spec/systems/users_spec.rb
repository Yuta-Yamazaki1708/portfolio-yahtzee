require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
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

  describe "ユーザー登録機能テスト" do
    let(:user) { create(:user) }

    before do
      user.icon.attach(fixture_file_upload('icon.jpg'))
    end

    it "新規登録できること" do
      new_user = build(:user)
      visit new_user_registration_path

      within "#new_user" do
        fill_in "アカウント名", with: new_user.username
        fill_in "メールアドレス", with: new_user.email
        fill_in "パスワード", with: new_user.password
        fill_in "パスワード確認", with: new_user.password_confirmation
        click_on "新規登録"
      end

      expect(page).to have_content "新規登録が完了しました。"
    end

    it "ログインができること" do
      visit new_user_session_path

      within "#new_user" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_on "ログイン"
      end

      expect(page).to have_content "ログインに成功しました。"
    end

    it "ログアウトができること" do
      sign_in user
      visit root_path

      find("#icon").hover
      click_on "ログアウト"

      expect(page).to have_content "ログアウトしました。"
    end

    it "退会ができること" do
      sign_in user
      visit edit_user_registration_path

      click_on "退会する"
      page.accept_confirm

      expect(page).to have_content "退会が完了しました。"
    end

    it "プロフィール編集ができること" do
      sign_in user
      visit root_path

      find("#icon").hover
      click_on "マイページ"
      click_on "プロフィール編集"
      within ".profile" do
        fill_in "アカウント名", with: "new_name"
        attach_file "アイコン画像", 'spec/fixtures/files/icon.jpg'
        click_on "編集を完了"
      end

      expect(page).to have_content "プロフィールを更新しました。"
      expect(page).to have_content "new_name"
      expect(user.reload.username).to eq "new_name"
    end

    it "アカウント設定ができること" do
      sign_in user
      visit root_path

      find("#icon").hover
      click_on "アカウント設定"

      within ".user-form" do
        fill_in "メールアドレス", with: "new@example.com"
        fill_in "新しいパスワード 変更しない場合は空欄", with: "newpassword"
        fill_in "パスワード確認 変更しない場合は空欄", with: "newpassword"
        fill_in "現在のパスワード 必須", with: "password"
        click_on "更新する"
      end

      expect(page).to have_content "アカウント設定を更新しました。"
      expect(user.reload.email).to eq "new@example.com"
    end

    # it "ログアウト中にプロフィール画面にアクセスできないこと" do
    #   visit profile_path(user)

    #   expect(current_path).to eq new_user_session_path
    #   expect(page).to have_content "ログインもしくはアカウント登録してください。"
    # end

    it "ログアウト中にアカウント設定にアクセスできないこと" do
      visit edit_user_registration_path

      expect(current_path).to eq new_user_session_path
    end
  end
end
