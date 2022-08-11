# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice_report = reports(:alice_report)
  end

  test '#editable?(target_user)' do
    alice = users(:alice)
    bob = users(:bob)

    assert @alice_report.editable?(alice)
    assert_not @alice_report.editable?(bob)
  end

  test '#created_on' do
    assert_equal Date.new(2022, 7, 23), @alice_report.created_on
  end
end
