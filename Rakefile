app_path = File.expand_path(File.join(__FILE__, ".."))
$LOAD_PATH.unshift(app_path)

desc "Seed the database with test data"
task :seed do
  require 'overheard'
  require 'faker'
  10.times do
    Overheard.create({ :body => Faker::Lorem.sentence })
  end
end
