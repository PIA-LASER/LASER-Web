require "rubygems"
require "json"

class LaserURL
  NAMESPACE = "urls."

  def self.all

  end

  def self.get(id)
    key_url = "#{NAMESPACE}#{id}.url"
    key_title = "#{NAMESPACE}#{id}.title"
    
    url = redis.get(key_url)
    title = redis.get(key_title)

    {
      :url => url,
      :title => title
    }
  end

  def self.redis
    settings.redis_connection
  end
end
