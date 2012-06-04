require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'rack/test'
require 'redis'
require 'json'

require './laser'

def add_user(name, recommendations)
  redis = Redis.new
  recommendations.times do
    redis.zadd("users.#{name}", rand, random_string(8))
  end

  { "name" => name }
end

def add_users(base, amount)
  (0...amount).map do |cnt|
    add_user(base + random_string(8), 10)
  end
end

def random_string(length)
  (0...length).map{65.+(rand(25)).chr}.join
end

def clear_users
  redis = Redis.new
  redis.flushdb
end
