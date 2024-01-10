require 'rails_helper'
require 'open-uri'

RSpec.describe "Users", type: :request do
  describe "google_oauth2" do
    subject { get '/users/auth/google_oauth2/callback', params: { provider: "google_oauth2" } }

    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      subject
    end

    it 'リダイレクトが302を返すこと' do
      expect(response).to have_http_status(302)
    end

    it '正しいリダイレクト先に遷移していること' do
      expect(response).to redirect_to(root_path)
    end
  end
end
