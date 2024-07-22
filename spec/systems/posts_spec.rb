require 'rails_helper'

RSpec.describe "Posts", type: :system, js: true do
  describe "結果投稿テスト" do
    let(:user) { create(:user, username: "test") }
    let(:game) { create(:game, sum: 100) }
    let!(:post) { create(:post, user_id: user.id, game_id: game.id) }

    before do
      user.icon.attach(fixture_file_upload('icon.jpg'))
      sign_in user
      visit root_path
    end

    it "結果を投稿できること" do
      click_on "プレイする"
      sleep(1)
      select "1", from: "player_num"
      select "3", from: "times_roll"
      click_on "開始する"
      sleep(1)
      12.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end
      click_on("結果を投稿する")
      click_on("投稿")
      sleep 1
      expect(page).to have_content "結果を投稿しました。"
    end

    it "結果を削除できること" do
      click_on("削除", match: :first)
      sleep 1
      page.accept_confirm
      sleep 1
      expect(page).to have_content "投稿を削除しました。"
    end

    it "ユーザープロフィールを閲覧できること" do
      click_on ("test")
      sleep 1
      expect(current_path).to eq profile_path(user)
    end

    it "ゲーム結果を閲覧できること" do
      click_on (100)
      sleep 1
      expect(current_path).to eq result_path(game)
    end
  end
end
