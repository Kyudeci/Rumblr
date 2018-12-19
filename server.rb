require 'sinatra'
require 'sinatra/reloader'

require 'sqlite3'
require 'active_record'
require './models/user.rb'

enable :sessions
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/user.db'
)
# ruby server.rb -o 0.0.0.0 -p 3000
get "/" do
  erb :index, :layout => :primary_layout
end
# Instead of creating a seperate page, create a modal?.
get "/blog" do
  @user = User.find(session[:user_id])
  erb :blogpost, :layout => :blog_layout
end
post "/" do
  user = User.find_by(username: params["username"], password: params["password"])
  if user
    puts user
    session[:user_id] = user.id
    redirect '/blog'
  else
    redirect '/'
  end
end

get "/login" do
  erb :login
end
