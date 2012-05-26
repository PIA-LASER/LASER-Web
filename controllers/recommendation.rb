require "rubygems"
require "json"

require "models/recommendation"

# Recommendation API

get "/api/recommendation" do
  "returns recommendation API discovery"
end

get "/api/recommendation/:username" do
  "returns recommendations for #{params[:username]}"
end
