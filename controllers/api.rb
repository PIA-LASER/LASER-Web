require "rubygems"
require "json"

# API discovery

get "/api" do
  content_type :json

  {
    :users => { :href => "/api/users" },
    :recommendation => { :href => "/api/recommendation" }
  }.to_json
end
