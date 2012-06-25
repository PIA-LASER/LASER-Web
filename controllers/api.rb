require "rubygems"
require "json"

# API discovery

get "/api" do
  content_type :json

  {
    :users => { :href => "/api/users" },
    :autocompletion => { :href => "/api/autocompletion" },
    :url => { :href => "/api/urls" }
  }.to_json
end
