require 'sinatra'
require 'sinatra/reloader'


get "/" do
  erb :index, :layout => :primary_layout
end
# Instead of creating a seperate page, create a modal?.
get "/signup" do
  erb :signup
end

get "/login" do
  erb :login
end
