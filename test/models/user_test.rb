# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
    @noname = users(:noname)
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
    assert_not @bob.following?(@carol)
    assert_difference('Relationship.count', 1) do
      @bob.follow(@carol)
    end
    assert @bob.following?(@carol)

    assert_no_difference('Relationship.count') do
      @bob.follow(@carol)
    end
  end

  test '#unfollow(user)' do
    assert @alice.following?(@bob)
    assert_difference('Relationship.count', -1) do
      @alice.unfollow(@bob)
    end
    assert_not @alice.following?(@bob)

    assert_no_difference('Relationship.count') do
      @alice.unfollow(@bob)
    end
  end

  test '#name_or_email' do
    assert_equal 'アリス', @alice.name_or_email
    assert_equal 'noname@example.com', @noname.name_or_email
  end
end
