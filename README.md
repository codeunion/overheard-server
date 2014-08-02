# Overheard - The Server
In a world where anything you say can be hilarious out of
context; one web application stands to aggregate your most
embaressing utterances.

That web app is Overheard.

Overheard is [licensed under the MIT License](LICENSE)

## Using Overheard
Overheard is meant to be hosted by the group that want to use
it to keep track of the silly things their friends/colleagues
say.

There are two ways to interact with Overheard:
1. Browsing overheards via the web interface
1. Using the REST API to add and list Overheards

For a list of planned and implemented features, known bugs, etc. check the
[CHANGELOG](CHANGELOG.md)


## Developing Overheard
All contributors are governed under the [Contributor Code of
Conduct](CODE_OF_CONDUCT.md).

Overheard welcomes all contributions, be they [issues](issues) or
[patches](pulls) from all people. Our [Contributor Guidelines](CONTRIBUTING.md)
provide advice for ensuring your issue or patch is resolved quickly.

### Running and Testing
First, set up the projects system level dependencies:

* [Ruby 1.9.3+](https://www.ruby-lang.org/en/installation/)
* [Bundler](http://bundler.io/#getting-started)
* [Sqlite](http://www.sqlite.org) and it's development headers
  * OS X: Install [homebrew](https://github.com/Homebrew/homebrew/wiki/Installation) then run `brew install sqlite`
  * Ubuntu: run `sudo apt-get install sqlite3 libsqlite3-dev`
  * Windows: Not sure, maybe [start here?](https://github.com/sparklemotion/sqlite3-ruby/issues/82)

Then you should be good to:

1. [Fork](https://help.github.com/articles/working-with-repositories#forking)
   and
   [Clone](https://help.github.com/articles/working-with-repositories#cloning)
   this repository.
1. `bundle install` - Install all the ruby dependencies
1. `cp .env.example .env` - Set up your local environment
1. `rake seed` - Loads fake data into the local database
1. `rerun -c bundle exec rackup` - Starts the web server
1. `rerun -xc bundle exec ruby test/all.rb` - Runs the tests over and over

### Deploying A Development Version
To deploy your own, we recommend you use Heroku. It's certainly possible to run
on your own infrastructure, it's just a bit harder. Overheard runs on Heroku
out of the box.

First, make sure you've setup:

* A [Heroku account](https://dashboard.heroku.com/account)
* The [Heroku Toolbelt](https://toolbelt.heroku.com/)

Then deploy that sucker!

1. `heroku create`
1. `git push heroku master`
1. `heroku open`
