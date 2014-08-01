if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load(".env.#{ENV['RACK_ENV']}", ".env")
end

require 'data_mapper'
DataMapper.setup(:default, ENV['DATABASE_URL'])
