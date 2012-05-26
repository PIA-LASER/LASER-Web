require "rubygems"

# Recommendation API

get "/api/recommendation/:username" do
  "returns recommendations for #{params[:username]}"
end
