require "rubygems"
require "json"

class Users
  NAMESPACE = 'users.'

  def self.all
    find("*")
  end

  def self.find(name)
    redis.keys("#{NAMESPACE}#{name}").map do |user|
      { :name => user.gsub(NAMESPACE, "") }
    end
  end

  def self.get(name, rec_amount = -1)
    redis.zrevrange("#{NAMESPACE}#{name}", 0, rec_amount)

      { :name => name }
  end

  private

  def self.redis
    settings.redis_connection
  end

end
