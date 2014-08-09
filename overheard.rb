require 'sinatra'
require 'config/environment'

class Overheard
  include DataMapper::Resource

  property :id, Serial
  property :body, Text, { :required => true }
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @overheards = Overheard.all
  erb :home
end

get '/overheards/new' do
  @overheard = Overheard.new
  erb :new_overheard
end

post '/overheards' do

  if request.form_data? && request.accept?("text/html")
    @overheard = Overheard.create(params["overheard"])
    if @overheard.saved?
      redirect "/"
    else
      erb :new_overheard
    end
  elsif !request.form_data? && request.accept?("application/json")
    request.body.rewind
    body_json = JSON.parse(request.body.read)
    overheard = Overheard.create(body_json["overheard"])
    status 200
    content_type "application/json"
    JSON.dump({ "overheard" => overheard.attributes })
  end
end
