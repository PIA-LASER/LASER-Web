require "rubygems"
require "erb"

get "/" do
  erb :'index.html'
end

get "/about/" do
  erb :'about.html'
end
