# frozen_string_literal: true

require 'test_helper'
require 'playwright_driver'
require 'capybara-screenshot/minitest'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright, using: :chrome, screen_size: [1400, 1400]
end
