require "rubygems"
require "json"
require "lib/model"

class Users < Model
  NAMESPACE = 'users.'

  def self.all
    find("*")
  end

  def self.find(name)
    keys(name).map do |name|
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

    {
      :name => name,
      :href => "/api/users/#{name}",
      :recommendations => recommendations
    }
  end

  def self.keys(search_clause)
    redis.keys("#{NAMESPACE}#{search_clause}").map do |user|
      user.gsub(NAMESPACE, "")
    end
  end

  def self.search_keys(search_clause, limit = -1)
    limit = limit.to_i
    found_keys = keys(search_clause)
    found_keys = found_keys.first(limit) if limit > 0

    { :results => found_keys}
  end

end
