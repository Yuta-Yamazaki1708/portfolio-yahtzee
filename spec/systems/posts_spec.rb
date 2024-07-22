require 'rails_helper'

RSpec.describe "Posts", type: :system, js: true do
  describe "結果投稿テスト" do
    let(:user) { create(:user) }
    let(:game) { create(:game) }
    let(:post) { build(:post, user_id: user.id, game_id: game.id) }

    before do
      visit root_path
      click_on "ゲストログイン"
      sleep(1)
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
      click_on "結果を投稿する"
    end

    it "結果を投稿できること" do
      click_on("投稿")
      sleep 1
      expect(page).to have_content "結果を投稿しました。"
    end

    it "結果を削除できること" do
      click_on("投稿")
      sleep 1
      visit root_path
      click_on("削除", match: :first)
      sleep 1
      page.accept_confirm
      sleep 1
      expect(page).to have_content "投稿を削除しました。"
    end
  end
end
