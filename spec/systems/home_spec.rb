require 'rails_helper'

RSpec.describe "Homes", type: :system do
  before do
    driven_by(:rack_test)
    visit root_path
  end

  it "logoをクリックしたとき、home画面へ遷移できること" do
    within('.logo') do
      click_on "Yahtzee"
      expect(current_path).to eq root_path
    end
  end

  it "home画面へのリンクをクリックしたとき、home画面へ遷移できること" do
    within('header') do
      click_on "Home"
      expect(current_path).to eq root_path
    end
  end

  it "ヘッダーのログインボタンをクリックしたとき、ログイン画面へ遷移できること" do
    within('header') do
      click_on "ログイン"
      expect(current_path).to eq new_user_session_path
    end
  end

  it "ヘッダーの新規登録ボタンをクリックしたとき、新規登録画面へ遷移できること" do
    within('header') do
      click_on "新規登録"
      expect(current_path).to eq new_user_registration_path
    end
  end

  it "メインのログインボタンをクリックしたとき、ログイン画面へ遷移できること" do
    within('#hero') do
      click_on "ログイン"
      expect(current_path).to eq new_user_session_path
    end
  end
end
