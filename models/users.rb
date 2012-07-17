#<Encoding:UTF-8>

require "rubygems"
require "json"
require "lib/model"

p __ENCODING__

class Users < Model
  USER_NAMESPACE = 'users.'
  URL_NAMESPACE = 'urls.'

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
    puts key
    recs = redis.zrevrange(key, 0, amount)

    recommendations = recs.map do |item|
      score_recommendations(item)
    end.sort { |a, b| a[:score] <=> b[:score] }

    {
      :name => name,
      :href => "/api/users/#{name}",
      :recommendations => recommendations
    }
  end

  def self.score_recommendations(item)
    user_key = "#{USER_NAMESPACE}#{name}"
    url_key = "#{URL_NAMESPACE}#{item}"

    timestamp = redis.get("#{url_key}.timestamp")
    popularity = redis.get("#{url_key}.popularity")
    preference = redis.zscore(user_key, item)
    time_delta = ((Time.now - Time.at(timestamp)) / 3600).to_i

    score = (popularity / ((time_delta ^ 1.8) + 1)) * preference

    { :item => item, :score => score }
  end

  def self.keys(search_clause)
    redis.keys("#{USER_NAMESPACE}#{search_clause}").map do |user|
      user.gsub(USER_NAMESPACE, "")
    end
  end

  def self.search_keys(search_clause, limit = -1)
    limit = limit.to_i
    found_keys = keys(search_clause)
    found_keys = found_keys.first(limit) if limit > 0

    { :results => found_keys}
  end

end
