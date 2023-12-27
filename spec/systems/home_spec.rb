require 'rails_helper'

RSpec.describe "Homes", type: :system do
  before do
    driven_by(:rack_test)
    visit root_path
  end

  it "logoをクリックしたとき、home画面へ遷移すること" do
    within('.logo') do
      click_on('Yahtzee')
      expect(current_path).to eq root_path
    end
  end

  it "home画面へのリンクをクリックしたとき、home画面へ遷移すること" do
    click_on 'Home'
    expect(current_path).to eq root_path
  end
end
