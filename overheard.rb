require 'sinatra'
require 'json'
require 'config/environment'

class Overheard
  include DataMapper::Resource

  property :id, Serial
  property :body, Text, { :required => true }
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

helpers do
  def render_json(hash)
    content_type "application/json"
    JSON.dump(hash)
  end

  def request_data
    return @request_data if @request_data
    if request.form_data?
      @request_data = params
    elsif request.content_type == "application/json"
      request.body.rewind
      @request_data = JSON.parse(request.body.read)
    end
  end

  CONTENT_TYPES = {
    :html => "text/html",
    :json => "application/json"
  }
  def requesting? content_type
    request.accept?(CONTENT_TYPES[content_type])
  end
end

get '/' do
  @overheards = Overheard.all(:order => [:created_at.asc])
  if requesting?(:html)
    erb :home
  elsif requesting?(:json)
    render_json({ :overheards => @overheards })
  end
end

get '/overheards/new' do
  @overheard = Overheard.new
  erb :new_overheard
end

post '/overheards' do
  @overheard = Overheard.create({ "body" => request_data["overheard"]["body"] })
  status @overheard.saved? ? 200 : 400

  if requesting?(:html)
    if @overheard.saved?
      redirect "/"
    else
      erb :new_overheard
    end
  elsif requesting?(:json)
    response_json = { "overheard" => @overheard.attributes }
    response_json["overheard"]["errors"] = @overheard.errors.to_h
    render_json(response_json)
  end
end
