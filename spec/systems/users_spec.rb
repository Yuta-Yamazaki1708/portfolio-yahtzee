require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  describe "ページ遷移テスト" do
    let(:user) { create(:user) }

    before do
      user.icon.attach(fixture_file_upload('icon.jpg'))
    end

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

    it "プロフイール編集からプロフィール画面へ戻れること" do
      sign_in user
      visit profile_path(user)

      click_on "プロフィール編集"
      click_on "戻る"

      expect(current_path).to eq profile_path(user)
      expect(page).to have_content "アカウント名:#{user.username}"
    end

    it "アカウント設定からホーム画面へ戻れること" do
      sign_in user
      visit edit_user_registration_path

      click_on "戻る"
      sleep 1

      expect(current_path).to eq root_path
    end
  end

  describe "ユーザー登録機能テスト" do
    let(:user) { create(:user) }
    let(:guest_user) { create(:user, username: "ゲスト", email: "guest@example.com") }

    before do
      user.icon.attach(fixture_file_upload('icon.jpg'))
      guest_user.icon.attach(fixture_file_upload('icon.jpg'))
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
      user_id = user.id
      visit edit_user_registration_path

      click_on "退会する"
      page.accept_confirm

      expect(page).to have_content "退会が完了しました。"
      User.exists?(id: user_id).should be_falsey
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

    it "ログアウト中にプロフィール編集にアクセスできないこと" do
      visit edit_profile_path

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content "ログインもしくはアカウント登録してください。"
    end

    it "ログアウト中にアカウント設定にアクセスできないこと" do
      visit edit_user_registration_path

      expect(current_path).to eq new_user_session_path
    end

    it "ログイン中にログイン画面にアクセスできないこと" do
      sign_in user
      visit new_user_session_path

      expect(current_path).to eq root_path
      expect(page).to have_content "すでにログインしています。"
    end

    it "ログイン中に新規登録画面にアクセスできないこと" do
      sign_in user
      visit new_user_registration_path

      expect(current_path).to eq root_path
      expect(page).to have_content "すでにログインしています。"
    end

    it "ホーム画面からゲストログインができること" do
      visit root_path

      click_on "ゲストログイン"

      expect(page).to have_content "ゲストユーザーでログインしました。"
    end

    it "ログイン画面からゲストログインができること" do
      visit new_user_session_path

      click_on "ゲストログイン"

      expect(page).to have_content "ゲストユーザーでログインしました。"
    end

    it "新規登録画面からゲストログインができること" do
      visit new_user_registration_path

      click_on "ゲストログイン"

      expect(page).to have_content "ゲストユーザーでログインしました。"
    end

    it "ゲストアカウントはプロフィール編集とアカウント編集ができないこと" do
      sign_in guest_user
      guest_user_id = guest_user.id
      visit profile_path(guest_user)

      click_on "プロフィール編集"
      fill_in "アカウント名", with: "new_guest_name"
      click_on "編集を完了"

      expect(page).to have_content "ゲストユーザーは編集、退会ができません。"
      expect(guest_user.reload.username).to eq "ゲスト"

      visit edit_user_registration_path

      fill_in "メールアドレス", with: "new_guest@example.com"
      fill_in "現在のパスワード 必須", with: "password"
      click_on "更新する"

      expect(page).to have_content "ゲストユーザーは編集、退会ができません。"
      expect(guest_user.reload.email).to eq "guest@example.com"

      click_on "退会する"
      page.accept_confirm

      expect(page).to have_content "ゲストユーザーは編集、退会ができません。"
      User.exists?(id: guest_user_id).should be_truthy
    end
  end

  describe "ゲーム結果" do
    let(:game1) { build(:game, sum: 100) }
    let(:game2) { build(:game, sum: 200) }
    let(:game3) { create(:game, sum: 150) }
    let(:user) { create(:user, games: [game1, game2, game3]) }

    before do
      user.icon.attach(fixture_file_upload('icon.jpg'))
      sign_in user
      visit profile_path(user)
    end

    it "ゲーム結果が表示されること" do
      within(".result") do
        expect(page). to have_content 200
        expect(page). to have_content 150
        expect(page). to have_content 100
      end
    end

    it "プレイ回数が表示されること" do
      within(".profile") do
        expect(page).to have_content 3
      end
    end

    it "ハイスコアが表示されること" do
      within(".profile") do
        expect(page).to have_content 200
      end
    end

    it "日付の降順で表示されること" do
      expect(page.text).to match %r{#{game3.sum}[\s\S]*#{game2.sum}[\s\S]*#{game1.sum}}
    end

    it "日付の昇順で表示できること" do
      click_on("日付⌄")
      sleep 1

      expect(page.text).to match %r{#{game1.sum}[\s\S]*#{game2.sum}[\s\S]*#{game3.sum}}
      expect(page).to have_content "日付^"
    end

    it "合計の昇順で表示できること" do
      click_on("合計⌄")
      sleep 1

      expect(page.text).to match %r{#{game1.sum}[\s\S]*#{game3.sum}[\s\S]*#{game2.sum}}
      expect(page).to have_content "合計^"
    end

    it "合計の降順で表示できること" do
      click_on("合計⌄")
      click_on("合計^")
      sleep 1

      expect(page.text).to match %r{#{game2.sum}[\s\S]*#{game3.sum}[\s\S]*#{game1.sum}}
      expect(page).to have_content "合計⌄"
    end

    it "ゲーム結果を削除できること" do
      click_on("削除", match: :first)
      sleep 1
      page.accept_confirm
      sleep 1
      expect(page).to have_content "結果を削除しました。"
    end
  end

  describe "ページネーションテスト" do
    before do
      games = create_list(:game, 11)
      user = create(:user, games: games)
      user.icon.attach(fixture_file_upload('icon.jpg'))
      sign_in user
      visit profile_path(user)
    end

    it "1ページ目に表示される結果は10個であること" do
      within('table') do
        num = page.all("tr").count - 1
        expect(num).to eq 10
      end
    end

    it "2ページ目に表示される結果は1個であること" do
      click_on("次へ ›")
      within('table') do
        num = page.all("tr").count - 1
        expect(num).to eq 1
      end
    end
  end
end
