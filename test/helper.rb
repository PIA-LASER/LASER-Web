require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'rack/test'
require 'redis'
require 'json'

require './laser'

def add_user(user, recommendations)
  redis = Redis.new
  recommendations.times do
    redis.zadd("users.#{user}", rand, (0...8).map{65.+(rand(25)).chr}.join)
  end
end

def add_users(base, amount)
  amount.times do |i|
    add_user(base + i.to_s, 10)
  end
end
