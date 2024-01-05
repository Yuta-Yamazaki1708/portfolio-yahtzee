Capybara.register_driver :remote_chrome do |app|
  url = 'http://chrome:4444/wd/hub'
  options = Selenium::WebDriver::Options.chrome
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.app_host = "http://#{Capybara.server_host}"
    driven_by :remote_chrome
  end
end
