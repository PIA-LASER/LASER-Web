require "rubygems"
require "erb"

get "/" do
  erb :'index.html'
end
