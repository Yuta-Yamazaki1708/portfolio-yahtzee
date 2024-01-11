OmniAuth.configure do |config|
  config.test_mode = true
  config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :provider => "google_oauth2",
    :uid => "123456789",
    :info => {
      :name => "John Doe",
      :email => "john.doe@example.com",
      :first_name => "John",
      :last_name => "Doe",
      :image => nil,
    },
  })
end
