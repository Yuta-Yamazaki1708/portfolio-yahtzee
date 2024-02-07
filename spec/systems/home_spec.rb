require 'rails_helper'

RSpec.describe "Homes", type: :system do
  before do
    driven_by(:rack_test)
    visit root_path
  end

  it "logoをクリックしたとき、home画面へ遷移できること" do
    within('.logo') do
      click_on "Yahtzee"
    end
    expect(current_path).to eq root_path
  end

  it "home画面へのリンクをクリックしたとき、home画面へ遷移できること" do
    within('header') do
      click_on "ホーム"
    end
    expect(current_path).to eq root_path
  end

  it "ヘッダーのログインリンクをクリックしたとき、ログイン画面へ遷移できること" do
    within('header') do
      click_on "ログイン"
    end
    expect(current_path).to eq new_user_session_path
  end

  it "ヘッダーの新規登録リンクをクリックしたとき、新規登録画面へ遷移できること" do
    within('header') do
      click_on "新規登録"
    end
    expect(current_path).to eq new_user_registration_path
  end

  it "ヘッダーのプレイボタンをクリックしたとき、ゲーム画面へ遷移できること" do
    within('header') do
      click_on "プレイ"
      sleep(1)
    end
    expect(current_path).to eq game_path
  end

  it "ヘッダーのランキングリンクをクリックしたとき、ランキング画面へ遷移できること" do
    within('header') do
      click_on "ランキング"
    end
    expect(current_path).to eq ranking_path
  end

  it "メインのログインボタンをクリックしたとき、ログイン画面へ遷移できること" do
    within('#hero') do
      click_on "ログイン"
    end
    expect(current_path).to eq new_user_session_path
  end

  it "メインのプレイするボタンをクリックしたとき、ゲーム画面へ遷移すること" do
    within('#hero') do
      click_on "プレイする"
      sleep(1)
    end
    expect(current_path).to eq game_path
  end
end
