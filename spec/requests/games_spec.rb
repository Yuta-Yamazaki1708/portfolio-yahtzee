require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /get_roll_count" do
    let(:user) { build(:user) }
    before do
      sign_in user
      get "/get_roll_count"
    end

    it "httpステータス200を取得できること" do
      expect(response).to have_http_status(200)
    end

    it "json形式で取得できること" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "サイコロを振った回数とサイコロを振る最大数が取得できること" do
      expect(response.body).to include("roll_count")
      expect(response.body).to include("max_roll_dices")
    end
  end
end
