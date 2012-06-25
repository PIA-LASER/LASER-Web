require "rubygems"
require "json"

require "models/users"

# Autocompletion

get "/api/autocomplete" do
  content_type :json
  Users.search_keys('*').to_json
end

get "/api/autocomplete/limit/:amount" do
  content_type :json
  Users.search_keys('*', params[:amount]).to_json
end

get "/api/autocomplete/:searchstring" do
  content_type :json
  Users.search_keys("*#{params[:searchstring]}*").to_json
end

get "/api/autocomplete/:searchstring/limit/:amount" do
  content_type :json
  Users.search_keys("*#{params[:searchstring]}*", params[:amount]).to_json
end

