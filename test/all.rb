require 'minitest/autorun'
ENV['RACK_ENV'] ||= 'test'
test_path = File.expand_path(File.join(__FILE__, ".."))
app_path  = File.expand_path(File.join(__FILE__, "..", ".."))
$LOAD_PATH.unshift(app_path)

require 'config/environment'
require 'test/features/list_overheards_test'
require 'test/features/create_overheards_test'
