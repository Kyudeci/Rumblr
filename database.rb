# Run this script with `bundle exec ruby app.rb`
require 'active_record'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
# require '.models/x.rb'
require './models/user.rb'
require './models/posts.rb'
# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
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
binding.pry
