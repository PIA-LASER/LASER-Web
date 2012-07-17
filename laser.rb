$LOAD_PATH << File.dirname(__FILE__)

require "rubygems"
require "bundler/setup"
require "sinatra"
require "redis"
require "logger"
require 'set'

configure do
  set :environment, :development
  set :logger, Logger.new("#{File.dirname(__FILE__)}/logs/sinatra.log")
  set :redis_connection, Redis.new(:host => "master", :db => 0)
end

# Load all controllers
Dir["controllers/*.rb"]. each { |file| require file }
