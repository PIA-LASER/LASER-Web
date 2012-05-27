require "rubygems"
require "json"

class Users
  NAMESPACE = 'users'

  def self.all
    redis.keys("#{NAMESPACE}.*")
  end

  def self.find(name)
    redis.keys("#{NAMESPACE}.#{name}")
  end

  def self.get(name, rec_amount)
    redis.zrevrange("#{NAMESPACE}.#{name}", 0, rec_amount)
  end

  private

  def self.redis
    settings.redis_connection
  end

end
