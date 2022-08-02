# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:ruby_chounyumon)
    login_by('alice@example.com')
  end

  test '本の一覧' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test '本の新規作成' do
    visit books_url
    click_on '新規作成'

    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '戻る'
  end

  test '本の編集' do
    visit books_url
    within 'table' do
      click_on '編集', match: :first
    end

    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '戻る'
  end

  test '本の削除' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
  end
end
