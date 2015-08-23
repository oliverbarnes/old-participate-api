[![Code Climate](https://codeclimate.com/github/oliverbarnes/participate-api/badges/gpa.svg)](https://codeclimate.com/github/oliverbarnes/participate-api)
[![Build Status](https://travis-ci.org/oliverbarnes/participate-api.svg?branch=master)](https://travis-ci.org/oliverbarnes/participate-api)

Please see the README on [repo for the front-end app](https://github.com/oliverbarnes/participate) to learn more about the project.

## Bootstrapping the Project


#### Ruby version and database

Install Ruby 2.2.2 if you don't have it yet

```
rvm install 2.2.2
```

(Or use whatever ruby version manager you prefer. There's a [.ruby-version](.ruby-version) for the project that should work with any of them)

Install MongoDB if you don't have it yet as well and start it up.

```
brew install mongodb
mongod --config /usr/local/etc/mongod.conf --logpath log/mongo.log
```

#### Bundle install and run tests

Ensure that dependencies are installed.

```
bundle install
```

Next, create an application.yml file. You can use our example.

```
cp config/application.yml.example config/application.yml
```

Then, run guard and start your test suite.

```
guard
```

(Hit Enter/Return to get Guard to run the test suite after starting up)

### For running the api with the ember front-end

```
rails s
```

Then startup the front-end app [by following the instructions on its github repo](http://github.com/oliverbarnes/participate).

Go to [`http://localhost:4200`](http://localhost:4200) on your browser.


## Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) guide.
