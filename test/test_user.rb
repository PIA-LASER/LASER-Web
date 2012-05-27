$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'helper'

set :environment, :test

class TestUserAPI < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    clear_users
  end

  def test_users_amount
    add_users('test', 10)
    get '/api/users'
    assert last_response.ok?
    assert last_response.content_type =~ /json/
    users = JSON.parse(last_response.body)
    assert_equal users.size, 10
  end

  def test_users_names
    expected_users = add_users('test', 10)
    get '/api/users'
    assert last_response.ok?
    actual_users = JSON.parse(last_response.body)
    assert_equal expected_users.sort, actual_users.sort
  end

end
