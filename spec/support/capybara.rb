require 'capybara/rspec'

Capybara.register_driver :remote_chrome do |app|
  url = ENV.fetch("SELENIUM_DRIVER_URL")
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => {
      "args" => [
        "no-sandbox",
        "headless",
        "disable-gpu",
        "disable-dev-shm-usage",
        "window-size=1680,1050"
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url:, capabilities: caps)
end
Capybara.javascript_driver = :remote_chrome

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    Capybara.server_host = ENV.fetch("CAPYBARA_HOST")
    Capybara.server_port = "4444"
    driven_by :remote_chrome
  end
end
