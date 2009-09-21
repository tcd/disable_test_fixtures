require 'test_helper'

class NonDisabledFixturesTest < ActiveSupport::TestCase

  def test_users
    assert_equal 1, User.find_all_by_email('ferko@suska.net').size
  end

  def test_posts
    assert_equal 3, Post.count
  end

  def test_comments
    assert_equal 5, Comment.all.size
  end

end

class DisableFixturesForAllTest < ActiveSupport::TestCase

  disable_fixtures_for :all

  def test_users
    assert_equal 0, User.find_all_by_email('ferko@suska.net').size
  end

  def test_posts
    assert_equal 0, Post.count
  end

  def test_comments
    assert_equal 0, Comment.all.size
  end

end

class DisableFixturesForRegexpTest < ActiveSupport::TestCase

  disable_fixtures_for /users/

  def test_users
    assert_equal 0, User.find_all_by_email('ferko@suska.net').size
  end

  def test_posts
    assert_equal 3, Post.count
  end

  def test_comments
    assert_equal 5, Comment.all.size
  end

end

class DisableFixturesForArrayOfNamesTest < ActiveSupport::TestCase

  disable_fixtures_for [ 'test_posts', 'test_comments' ]

  def test_users
    assert_equal 1, User.find_all_by_email('ferko@suska.net').size
  end

  def test_posts
    assert_equal 0, Post.count
  end

  def test_comments
    assert_equal 0, Comment.all.size
  end

end

class DisableFixturesForProcTest < ActiveSupport::TestCase

  disable_fixtures_for do |test_name|
    test_name == 'test_comments'
  end

  def setup
    super
  end

  def test_users
    assert_equal 1, User.find_all_by_email('ferko@suska.net').size
  end

  def test_posts
    assert_equal 3, Post.count
  end

  def test_comments
    assert_equal 0, Comment.all.size
  end

end
