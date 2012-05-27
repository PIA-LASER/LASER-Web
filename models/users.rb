require "rubygems"
require "json"

class Users
  NAMESPACE = 'users.'

  def self.all
    find("*")
  end

  def self.find(name)
    redis.keys("#{NAMESPACE}#{name}").map do |user|
      user.gsub(NAMESPACE, "")
    end
  end

  def self.get(name, rec_amount)
    redis.zrevrange("#{NAMESPACE}#{name}", 0, rec_amount)
  end

  private

  def self.redis
    settings.redis_connection
  end

end
