#<Encoding:UTF-8>
require "rubygems"
require "json"

require "models/url"

p __ENCODING__


get "/api/popular" do
  links = []

  LaserURL.get_popular.each do |link_id|
    links << LaserURL.get(link_id.to_s)
  end

  links.to_json
end
