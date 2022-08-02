# frozen_string_literal: true

require 'test_helper'
require_relative 'support/playwright_driver'
require 'capybara-screenshot/minitest'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright, using: :chrome, screen_size: [1400, 1400]

  def login_by(email)
    visit new_user_session_path

    fill_in 'Eメール', with: email
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    assert_text 'ログインしました。'
    assert_text "#{email} としてログイン中"
    assert_selector 'h1', text: '本'
  end

  def visit_reports_path_from_menu
    click_on '日報'
    assert_selector 'h1', text: '日報'
  end
end
