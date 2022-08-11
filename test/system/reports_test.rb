# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @alice_report = reports(:alice_report)
  end

  test '日報の一覧' do
    login_by('alice@example.com')
    click_on '日報'
    assert_selector 'h1', text: '日報'

    reports = Report.order(id: :desc)
    row_index = reports.find_index { |r| r.title == '2022年07月29日の日報' }

    within all('table tbody tr')[row_index] do
      assert_text '2022年07月29日の日報'
      assert_text 'ボブ'
      assert_text '2022/07/29'
    end
  end

  test '日報の新規作成' do
    login_by('alice@example.com')
    click_on '日報'
    assert_selector 'h1', text: '日報'

    click_on '新規作成'
    assert_selector 'h1', text: '日報の新規作成'

    within 'form' do
      fill_in 'タイトル', with: '2022年08月02日の日報'
      fill_in '内容', with: 'リーダブルテストコードについて学びました。'
    end

    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_selector 'h1', text: '日報の詳細'
    assert_text '2022年08月02日の日報'
    assert_text 'リーダブルテストコードについて学びました。'
  end

  test '日報の新規作成（ビジネス例外）' do
    login_by('alice@example.com')
    visit new_report_path

    click_on '登録する'

    within 'form' do
      assert_field 'タイトル', with: ''
      assert_field '内容', with: ''
    end

    within 'div#error_explanation' do
      assert_text 'タイトルを入力してください'
      assert_text '内容を入力してください'
    end
  end

  test '日報の編集' do
    login_by('alice@example.com')
    click_on '日報'
    assert_selector 'h1', text: '日報'

    find("a[href='#{edit_report_path(@alice_report)}']", text: '編集').click
    assert_selector 'h1', text: '日報の編集'
    within 'form' do
      assert_field 'タイトル', with: '2022年07月23日の日報'
      assert_field '内容', with: 'テスト技法について学びました。'
    end

    within 'form' do
      fill_in 'タイトル', with: 'アリスが更新した日報のタイトル'
      fill_in '内容', with: 'アリスが更新した日報の内容'
    end

    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_selector 'h1', text: '日報の詳細'
    assert_text 'アリスが更新した日報のタイトル'
    assert_text 'アリスが更新した日報の内容'
  end

  test '日報の編集（ビジネス例外）' do
    login_by('alice@example.com')
    visit edit_report_path(@alice_report)

    fill_in 'タイトル', with: ''
    fill_in '内容', with: ''

    click_on '更新する'

    assert_selector 'h1', text: '日報の編集'
    within 'form' do
      assert_field 'タイトル', with: ''
      assert_field '内容', with: ''
    end

    within 'div#error_explanation' do
      assert_text 'タイトルを入力してください'
      assert_text '内容を入力してください'
    end
  end

  test '日報の削除' do
    login_by('alice@example.com')
    click_on '日報'
    assert_selector 'h1', text: '日報'

    within 'table' do
      assert_text '2022年07月23日の日報'
    end

    page.accept_confirm do
      find("a[href='#{report_path(@alice_report)}']", text: '削除').click
    end

    assert_text '日報が削除されました。'
    assert_selector 'h1', text: '日報'

    within 'table' do
      assert_no_text '2022年07月23日の日報'
    end
  end
end
