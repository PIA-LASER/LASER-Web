require "rubygems"
require "json"
require "lib/model"

class LaserURL < Model
  NAMESPACE = "urls."

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

  def self.get_popular
    urls = redis.zrange("urls.popular",0,-1)
    urls
  end
end
