#<Encoding:UTF-8>
require "rubygems"
require "json"

require "models/url"

p __ENCODING__


get "/api/urls/:urlid" do
  LaserURL.get(params[:urlid]).to_json
end

