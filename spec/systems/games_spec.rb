require 'rails_helper'

RSpec.describe "Games", type: :system, js: true do
  describe "ゲームをプレイする" do
    it "ゲームを開始できること" do
      visit root_path
      click_on "プレイする"
      sleep(1)
      select "1", from: "player_num"
      select "3", from: "times_roll"
      click_on "開始する"
      sleep(1)

      expect(current_path).to eq game_path
    end

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
    end

    it "サイコロを振れること" do
      click_on "サイコロを振る"
      expect(page).to have_css(".table-dice", count: 5)
      expect(page).to have_content("残り 2 回振れます")
    end

    it "サイコロを3回振れる選択の場合、サイコロを4回振れないこと" do
      4.times { click_on "サイコロを振る" }
      expect(page).to have_content("サイコロを振れるのは3回までです。")
    end

    it "現在のサイコロとキープしたサイコロを移動できること" do
      click_on "サイコロを振る"
      first(:css, ".table-dice").click

      expect(page).to have_css(".table-dice", count: 4)
      expect(page).to have_css(".keep-dice", count: 1)

      first(:css, ".keep-dice").click

      expect(page).to have_css(".table-dice", count: 5)
      expect(page).to have_css(".keep-dice", count: 0)
    end

    it "サイコロを全てキープしたらサイコロを振るボタンが存在しないこと" do
      click_on "サイコロを振る"
      5.times do
        first(:css, ".table-dice").click
        sleep(5)
      end

      expect(page.has_no_link?("サイコロを振る")).to be_truthy
    end

    it "カテゴリを選択でき、サイコロを振れる回数がリセットされること" do
      click_on "サイコロを振る"
      first(:css, ".calculated_scores").click

      expect(page).to have_css(".result")
      expect(page).to have_content("残り 3 回振れます")
    end

    it "ゲームを終えられること" do
      12.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end

      expect(page).to have_content("もう一度プレイ")
      expect(page).to have_content("ホームに戻る")
    end

    it "ゲーム終了後、ゲームをリトライできること" do
      12.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end
      click_on "もう一度プレイ"
      sleep(1)
      select "1", from: "player_num"
      select "3", from: "times_roll"
      click_on "開始する"
      sleep(1)

      expect(current_path).to eq game_path
      expect(page).not_to have_css(".result")
    end

    it "ゲーム終了後、ホームへ戻れること" do
      12.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end
      sleep(1)
      click_on "ホームに戻る"
      sleep(1)

      expect(current_path).to eq root_path
    end

    it "ゲーム終了後、ランキングへ遷移できること" do
      12.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end
      sleep(1)
      within "main" do
        click_on "ランキング"
      end
      sleep(1)

      expect(current_path).to eq ranking_path
    end

    it "途中でリロードした場合ゲームを中止し、ホームに戻ること" do
      click_on "サイコロを振る"
      first(:css, ".calculated_scores").click
      sleep(1)
      visit current_path
      sleep(1)

      expect(current_path).to eq root_path
      expect(page).to have_content("リロードされたためゲームを中止しました。")
    end

    it "4人プレイができること" do
      visit root_path
      click_on "プレイする"
      sleep(1)
      select "4", from: "player_num"
      select "3", from: "times_roll"
      click_on "開始する"
      sleep(1)
      48.times do
        click_on "サイコロを振る"
        first(:css, ".calculated_scores").click
      end

      expect(page).to have_content("もう一度プレイ")
      expect(page).to have_content("ホームに戻る")
    end

    it "サイコロを5回振れる選択の場合、サイコロを６回振ないこと" do
      visit root_path
      click_on "プレイする"
      sleep(1)
      select "1", from: "player_num"
      select "5", from: "times_roll"
      click_on "開始する"
      sleep(1)
      6.times { click_on "サイコロを振る" }
      expect(page).to have_content("サイコロを振れるのは5回までです。")
    end
  end
end
