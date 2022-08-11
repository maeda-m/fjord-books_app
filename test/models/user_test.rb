# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
    @no_name = users(:no_name)
  end

  test '#following?(user)' do
    assert @alice.following?(@bob)
    assert_not @bob.following?(@carol)
    assert_not @carol.following?(@carol)
  end

  test '#followed_by?(user)' do
    assert @bob.followed_by?(@alice)
    assert_not @bob.followed_by?(@carol)
    assert_not @carol.followed_by?(@carol)
  end

  test '#follow(user)' do
    assert_changes('@bob.following?(@carol)', from: false, to: true) do
      @bob.follow(@carol)
    end

    assert_no_changes('@bob.following?(@carol)', from: false) do
      @bob.follow(@carol)
    end
  end

  test '#unfollow(user)' do
    assert_changes('@alice.following?(@bob)', from: true, to: false) do
      @alice.unfollow(@bob)
    end

    assert_no_changes('@alice.following?(@bob)', from: true) do
      @alice.unfollow(@bob)
    end
  end

  test '#name_or_email' do
    assert_equal 'アリス', @alice.name_or_email
    assert_equal 'no_name@example.com', @no_name.name_or_email
  end
end
