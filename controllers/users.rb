require "rubygems"
require "json"

require "models/users"

# Users API

get "/api/users" do
  content_type :json
  Users.all.to_json
end

get "/api/users/:username" do
  "returns #{params[:username]} as JSON"
end

get "/api/users/autocomplete" do
  "returns search API discovery"
end

get "/api/users/autocomplete/:searchstring" do
  "returns autocompletion for #{params[:searchstring]} as JSON"
end
