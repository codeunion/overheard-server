require 'sinatra'
require 'config/environment'

class Overheard
  include DataMapper::Resource

  property :id, Serial
  property :body, Text
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @overheards = Overheard.all
  erb :home
end
