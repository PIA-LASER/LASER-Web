require "rubygems"
require "json"

# Users API

get "/api/users" do
  "returns all users as JSON"
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
