$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'helper'

set :environment, :test

class TestAutoCompletionAPI < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    clear_users
  end

  def test_empty_set
    get '/api/autocomplete'
    autocomp_list = assert_and_parse(last_response)
    assert_empty autocomp_list["results"]
  end

  def test_amount
    add_users('test', 10)
    get '/api/autocomplete'
    autocomp_list = assert_and_parse(last_response)
    assert_equal 10, autocomp_list["results"].size
  end

  def test_usernames
    names = get_usernames(add_users('test', 10))
    get '/api/autocomplete'
    autocomp_list = assert_and_parse(last_response)
    assert_equal names, autocomp_list["results"].sort
  end

  def test_amount_limit
    add_users('test', 30)
    get '/api/autocomplete/limit/15'
    autocomp_list = assert_and_parse(last_response)
    assert_equal 15, autocomp_list["results"].size
  end

  def test_query
    add_users('hello', 23)
    add_users('world', 30)
    add_users('test', 20)

    names = get_usernames(add_users('actual', 30))
    get '/api/autocomplete/actu'
    autocomp_list = assert_and_parse(last_response)
    assert_equal names, autocomp_list["results"].sort
  end


  def test_query_amount_limit
    add_users('hello', 23)
    add_users('world', 30)
    add_users('test', 20)

    get '/api/autocomplete/hel/limit/10'
    autocomp_list = assert_and_parse(last_response)
    assert_equal 10, autocomp_list["results"].size
  end



  def assert_and_parse(last_response)
    assert last_response.ok?
    assert last_response.content_type =~ /json/

    JSON.parse(last_response.body)
  end

  def get_usernames(users)
    users.map { |user| user["name"] }.sort
  end

end
