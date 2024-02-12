require 'rails_helper'

RSpec.describe "Ranks", type: :system, js: true do
  describe "ランキング表示テスト" do
    let!(:game1) { create(:game, sum: 100, updated_at: Date.today) }
    let!(:game2) { create(:game, sum: 200, updated_at: Date.today - 10) }

    before do
      visit ranking_path
    end

    it "ランキングが表示できること" do
      expect(page).to have_content(100)
      expect(page).to have_content(200)
    end

    it "週間ランキングが表示できること" do
      click_on("週間")
      expect(page).to have_content(100)
      expect(page).not_to have_content(200)
    end
  end

  describe "ページネーションテスト" do
    before do
      create_list(:game, 11)
      visit ranking_path
    end

    it "1ページ目は結果が10個表示されること" do
      num = page.all("tr").count - 1
      expect(num).to eq 10
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
