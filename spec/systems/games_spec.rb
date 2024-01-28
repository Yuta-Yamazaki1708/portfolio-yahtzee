require 'rails_helper'

RSpec.describe "Games", type: :system, js: true do
  describe "ゲームをプレイする" do
    it "ゲームを開始できること" do
      visit root_path
      click_on "プレイする"
      sleep(1)
      expect(current_path).to eq game_path
    end

    before do
      visit root_path
      click_on "プレイする"
      sleep(1)
    end

    it "サイコロを振れること" do
      click_on "サイコロを振る"
      expect(page).to have_css(".table-dice", count: 5)
      expect(page).to have_content("残り 2 回振れます")
    end

    it "サイコロを4回振れないこと" do
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

    it "キープしたサイコロは振らないこと" do
      click_on "サイコロを振る"
      first(:css, ".table-dice").click
      keep_dice = first(:css, ".keep-dice")
      click_on "サイコロを振る"
      new_keep_dice = first(:css, ".keep-dice")

      expect(new_keep_dice).to eq keep_dice
    end

    it "サイコロを全てキープしたらサイコロを振るボタンが存在しないこと" do
      click_on "サイコロを振る"
      5.times { first(:css, ".table-dice").click sleep(2) }

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

    it "途中でリロードした場合ゲームを中止し、ホームに戻ること" do
      click_on "サイコロを振る"
      first(:css, ".calculated_scores").click
      sleep(1)
      visit current_path
      sleep(1)

      expect(current_path).to eq root_path
      expect(page).to have_content("リロードされたためゲームを中止しました。")
    end
  end
end
