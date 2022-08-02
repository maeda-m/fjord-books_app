# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    login_by('alice@example.com')
  end

  test '本へのコメント' do
    book = books(:ruby_chounyumon)
    visit book_path(book)

    assert_text 'コメントはまだありません'

    within 'form' do
      fill_in 'comment[content]', with: '1番目のコメントです。'
    end

    assert_difference 'Comment.count', 1 do
      click_on 'コメントする'
    end

    assert_text 'コメントが投稿されました。'
    assert_selector 'h1', text: '本の詳細'
    assert_text '1番目のコメントです。'
    assert_no_text 'コメントはまだありません'
  end

  test '日報へのコメント' do
    report = reports(:alice_report)
    visit report_path(report)

    assert_text 'コメントはまだありません'

    within 'form' do
      fill_in 'comment[content]', with: '1番目のコメントです。'
    end

    assert_difference 'Comment.count', 1 do
      click_on 'コメントする'
    end

    assert_text 'コメントが投稿されました。'
    assert_selector 'h1', text: '日報の詳細'
    assert_text '1番目のコメントです。'
    assert_no_text 'コメントはまだありません'
  end
end
