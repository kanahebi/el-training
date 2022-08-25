require 'capybara/rspec'

Capybara.register_driver :remote_chrome do |app|
  if ENV['CIRCLECI']
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1400,1400')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  else
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
end
Capybara.javascript_driver = :remote_chrome

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV['CIRCLECI']
      Capybara.server_host = ENV.fetch("CAPYBARA_HOST")
      Capybara.server_port = "4444"
    end
    driven_by :remote_chrome
  end
end
