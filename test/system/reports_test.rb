# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @alice_report = reports(:alice_report)
  end

  test '日報の新規作成' do
    login_by('alice@example.com')
    visit_reports_path_from_menu

    click_on '新規作成'
    assert_selector 'h1', text: '日報の新規作成'

    within 'form' do
      fill_in 'タイトル', with: 'これは日報のタイトルです'
      fill_in '内容', with: 'これは日報の内容です'
    end

    assert_difference 'Report.count' do
      click_on '登録する'
    end

    assert_text '日報が作成されました。'
    assert_selector 'h1', text: '日報の詳細'
    assert_text 'これは日報のタイトルです'
    assert_text 'これは日報の内容です'
  end

  test '日報の新規作成（ビジネス例外）' do
    login_by('alice@example.com')
    visit new_report_path

    assert_no_difference 'Report.count' do
      click_on '登録する'
    end

    within 'form' do
      assert_equal '', find('input[type=text]').value
      assert_equal '', find('textarea').value
    end

    within 'div#error_explanation' do
      assert_text 'タイトルを入力してください'
      assert_text '内容を入力してください'
    end
  end

  test '日報の編集' do
    login_by('alice@example.com')
    visit_reports_path_from_menu

    find("a[href='#{edit_report_path(@alice_report)}']", text: '編集').click
    assert_selector 'h1', text: '日報の編集'
    within 'form' do
      assert_equal @alice_report.title, find('input[type=text]').value
      assert_equal @alice_report.content, find('textarea').value
    end

    within 'form' do
      fill_in 'タイトル', with: 'アリスが更新した日報のタイトル'
      fill_in '内容', with: 'アリスが更新した日報の内容'
    end

    assert_no_difference 'Report.count' do
      click_on '更新する'
    end

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

    assert_no_difference 'Report.count' do
      click_on '更新する'
    end

    assert_selector 'h1', text: '日報の編集'
    within 'form' do
      assert_equal '', find('input[type=text]').value
      assert_equal '', find('textarea').value
    end

    within 'div#error_explanation' do
      assert_text 'タイトルを入力してください'
      assert_text '内容を入力してください'
    end
  end

  test '日報の削除' do
    login_by('alice@example.com')
    visit_reports_path_from_menu

    assert_difference 'Report.count', -1 do
      page.accept_confirm do
        find("a[href='#{report_path(@alice_report)}']", text: '削除').click
      end
    end

    assert_text '日報が削除されました。'
    assert_selector 'h1', text: '日報'
  end
end
