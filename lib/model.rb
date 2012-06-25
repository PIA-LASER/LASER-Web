require "rubygems"


class Model

  def self.redis
    settings.redis_connection
  end

end
