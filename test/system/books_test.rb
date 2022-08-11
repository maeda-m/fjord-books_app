# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    login_by('alice@example.com')
  end

  test '本の一覧' do
    visit books_url
    assert_selector 'h1', text: '本'

    books = Book.order(id: :desc)
    row_index = books.find_index { |b| b.title == 'チェリー本' }

    within all('table tbody tr')[row_index] do
      assert_text 'チェリー本'
      assert_text 'プログラミング経験者のためのRuby入門書です。'
      assert_text '伊藤 淳一'
    end
  end

  test '本の新規作成' do
    visit books_url
    click_on '新規作成'

    within 'form' do
      fill_in 'メモ', with: '楽々ERDレッスン'
      fill_in 'タイトル', with: '実在する帳票から本当に使えるテーブル設計を導く画期的な本！'
      fill_in '著者', with: '羽生 章洋'
    end

    click_on '登録する'

    assert_text '本が作成されました。'
    assert_selector 'h1', text: '本の詳細'
    assert_text '楽々ERDレッスン'
    assert_text '実在する帳票から本当に使えるテーブル設計を導く画期的な本！'
    assert_text '羽生 章洋'
  end

  test '本の編集' do
    book = books(:cherry_bon)

    visit books_url
    find("a[href='#{edit_book_path(book)}']", text: '編集').click

    within 'form' do
      assert_field 'タイトル', with: 'チェリー本'
      assert_field 'メモ', with: 'プログラミング経験者のためのRuby入門書です。'
      assert_field '著者', with: '伊藤 淳一'
    end

    within 'form' do
      fill_in 'タイトル', with: '更新した本のタイトル'
      fill_in 'メモ', with: '更新した本のメモ'
      fill_in '著者', with: '更新した本の著者'
    end

    click_on '更新する'

    assert_text '本が更新されました。'
    assert_selector 'h1', text: '本の詳細'
    assert_text '更新した本のタイトル'
    assert_text '更新した本のメモ'
    assert_text '更新した本の著者'
  end

  test '本の削除' do
    book = books(:cherry_bon)

    visit books_url

    within 'table' do
      assert_text 'チェリー本'
    end

    page.accept_confirm do
      find("a[href='#{book_path(book)}']", text: '削除').click
    end

    assert_text '本が削除されました。'

    within 'table' do
      assert_no_text 'チェリー本'
    end
  end
end
