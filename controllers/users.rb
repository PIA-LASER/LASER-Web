require "rubygems"

# Users API

get "/api/users" do
  "returns all users as JSON"
end

get "/api/users/:username" do
  "returns #{params[:username]} as JSON"
end

get "/api/users/autocomplete/:searchstring" do
  "returns autocompletion for #{params[:searchstring]} as JSON"
end
