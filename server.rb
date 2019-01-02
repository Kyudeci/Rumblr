require 'sinatra'
require 'sinatra/reloader'

require 'active_record'
require './models/user.rb'
require './models/posts.rb'

enable :sessions
if ENV['DATABASE_URL']
  require 'pg'
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/user.db'
  )
end
# ruby server.rb -o 0.0.0.0 -p 3000
get "/" do
  erb :index, :layout => :primary_layout
end
# Instead of creating a seperate page, create a modal?.
get "/blog" do
  @posts = Posts.all
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

post "/signup" do
copy_user = User.find_by(username: params["username"])
  if copy_user
    redirect "/"
  else
    user = User.create(first_name: params["first_name"], last_name: params["last_name"], birth_date: params["birth_date"], username: params["username"], password: params["password"], email: params["email"])
    session[:user_id] = user.id
    redirect '/'
  end
end
get "/logout" do
  session[:user_id] = nil
  redirect '/'
end
post "/blog" do
  @user = User.find(session[:user_id])
  @userPost = Posts.create(user_id: session[:user_id], username: @user.username, user_post: params["user_post"], title: params[:title])
  redirect "/blog"
end
get "/profile" do
  @user = User.find(session[:user_id])
  @users = User.all
  @posts = Posts.all
  erb :profile, :layout => :blog_layout
end
get "/profile/delete/:id" do
  @user = User.find(session[:user_id])
  Posts.find_by(username: @user.username).destroy
  User.find(params["id"]).destroy
  redirect "/"
end
