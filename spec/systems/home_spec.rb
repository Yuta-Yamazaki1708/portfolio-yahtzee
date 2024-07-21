require 'rails_helper'

RSpec.describe "Homes", type: :system, js: true do
  before do
    visit root_path
  end

  it "logoをクリックしたとき、home画面へ遷移できること" do
    within('.logo') do
      click_on "Yahtzee"
      sleep(1)
    end
    expect(current_path).to eq root_path
  end

  it "home画面へのリンクをクリックしたとき、home画面へ遷移できること" do
    within('header') do
      click_on "ホーム"
      sleep(1)
    end
    expect(current_path).to eq root_path
  end

  it "ヘッダーのログインリンクをクリックしたとき、ログイン画面へ遷移できること" do
    within('header') do
      click_on "ログイン"
      sleep(1)
    end
    expect(current_path).to eq new_user_session_path
  end

  it "ヘッダーの新規登録リンクをクリックしたとき、新規登録画面へ遷移できること" do
    within('header') do
      click_on "新規登録"
      sleep(1)
    end
    expect(current_path).to eq new_user_registration_path
  end

  it "ヘッダーのルールボタンをクリックしたとき、ゲーム画面へ遷移できること" do
    within('header') do
      click_on "ルール"
      sleep(1)
    end
    expect(current_path).to eq rules_path
  end

  it "ヘッダーのランキングリンクをクリックしたとき、ランキング画面へ遷移できること" do
    within('header') do
      click_on "ランキング"
      sleep(1)
    end
    expect(current_path).to eq ranking_path
  end

  it "メインのログインボタンをクリックしたとき、ログイン画面へ遷移できること" do
    within('#hero') do
      click_on "ログイン"
      sleep(1)
    end
    expect(current_path).to eq new_user_session_path
  end

  it "メインのプレイするボタンをクリックしたとき、ゲーム画面へ遷移すること" do
    click_on "ゲストログイン"
    sleep(1)
    within('#hero') do
      click_on "プレイする"
      sleep(1)
      select '1', from: 'player_num'
      sleep(1)
      select '3', from: 'times_roll'
      sleep(1)
      click_on "開始する"
      sleep(1)
    end
    expect(current_path).to eq game_path
  end

  it "メインのルールボタンをクリックしたとき、ルール画面へ遷移すること" do
    click_on "ゲストログイン"
    sleep(1)
    within('#hero') do
      click_on "ルール"
      sleep(1)
    end
    expect(current_path).to eq rules_path
  end

  it "メインのランキングボタンをクリックしたとき、ランキング画面へ遷移すること" do
    click_on "ゲストログイン"
    sleep(1)
    within('#hero') do
      click_on "ランキング"
      sleep(1)
    end
    expect(current_path).to eq ranking_path
  end
end
