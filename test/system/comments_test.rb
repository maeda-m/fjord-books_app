# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    login_by('alice@example.com')
  end

  test '本へのコメント' do
    book = books(:cherry_bon)
    visit book_path(book)

    assert_text 'コメントはまだありません'

    within 'form' do
      fill_in 'comment[content]', with: 'Ruby技術者認定試験の対策本におすすめです！'
    end

    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    assert_selector 'h1', text: '本の詳細'
    assert_text 'Ruby技術者認定試験の対策本におすすめです！'
    assert_no_text 'コメントはまだありません'
  end

  test '日報へのコメント' do
    report = reports(:alice_report)
    visit report_path(report)

    assert_text 'コメントはまだありません'

    within 'form' do
      fill_in 'comment[content]', with: '素晴らしい日報ですね！'
    end

    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    assert_selector 'h1', text: '日報の詳細'
    assert_text '素晴らしい日報ですね！'
    assert_no_text 'コメントはまだありません'
  end
end
