require "rubygems"
require "json"

require "models/users"

# Users API

get "/api/users" do
  content_type :json
  Users.all.to_json
end

get "/api/users/:username" do
  content_type :json
  Users.get(params[:username]).to_json
end

get "/api/users/:username/limit/:amount" do
  content_type :json
  Users.get(params[:username], params[:amount].to_i - 1).to_json
end

get "/api/users/autocomplete" do
  content_type :json
  Users.search_keys('*').to_json
end

