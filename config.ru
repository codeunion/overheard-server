app_path = File.expand_path(File.join(__FILE__, ".."))
$LOAD_PATH.unshift(app_path)
require 'overheard'


run Sinatra::Application
