require "rubygems"
require "json"
require "lib/model"

class Users < Model
  NAMESPACE = 'users.'

  def self.all
    find("*")
  end

  def self.find(name)
    redis.keys("#{NAMESPACE}#{name}").map do |user|
      name = user.gsub(NAMESPACE, "")
      get(name)
    end
  end

  def self.get(name, amount = -1)
    key = "#{NAMESPACE}#{name}"
    recs = redis.zrevrange(key, 0, amount)

    recommendations = recs.map do |item|
      score = redis.zscore(key, item)

      { :item => item, :score => score }
    end

    { :name => name,
      :href => "/api/users/#{name}",
      :recommendations => recommendations
    }
  end

end
