require 'sinatra'
require 'config/environment'

class Overheard
  include DataMapper::Resource
  # Declare our Overheard model is a DataMapper::Resource

  property :id, Serial
  property :body, Text
  property :created_at, DateTime

  # Properties what data our Overheard model contains. The first argument is
  # the name we use to reference the data, while the second is the type of data.
  #
  # http://datamapper.org/docs/properties.html
end

DataMapper.finalize
# Declares we're done defining our models.
# http://rdoc.info/github/datamapper/dm-core/DataMapper#finalize-class_method

DataMapper.auto_upgrade!
# Upgrades the database schema to reflect our models.
# http://rubydoc.info/github/datamapper/dm-migrations/DataMapper/Migrations/Repository#auto_upgrade%21-instance_method

get '/' do
  @overheards = Overheard.all
  erb :home
end
