require "rubygems"
require "json"

# Recommendation API

get "/api/recommendation" do
  "returns API discovery"
end

get "/api/recommendation/:username" do
  "returns recommendations for #{params[:username]}"
end
