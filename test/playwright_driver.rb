# frozen_string_literal: true

require 'capybara-playwright-driver'

Capybara.register_driver(:playwright) do |app|
  # See: https://playwright-ruby-client.vercel.app/docs/article/guides/rails_integration
  # See: https://github.com/microsoft/playwright/issues/3167
  Capybara::Playwright::Driver.new(
    app,
    playwright_cli_executable_path: './node_modules/.bin/playwright',
    browser_type: :chromium,
    headless: true
  )
end

Capybara.configure do |config|
  config.default_max_wait_time = 15
  config.default_driver = :playwright
  config.javascript_driver = :playwright
  config.save_path = 'tmp/capybara'
end
