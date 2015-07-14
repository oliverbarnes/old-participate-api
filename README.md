[![Build Status](https://travis-ci.org/oliverbarnes/participate-api.svg?branch=master)](https://travis-ci.org/oliverbarnes/participate-api)

Participate is a democratic participation plaftorm, based on [LiquidFeedback](http://liquidfeedback.org), the open source system used at the Pirate Party for its internal decision making and policy creation, and on its [principles](http://principles.liquidfeedback.org).

Development is in its early stages.

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

### Contributors
------------
Present and past:

- [William Jeffreys](https://github.com/williamcodes)
- [Qian Zhou](https://github.com/qianfinland)
- [Cathy Nangini](https://github.com/KatiRG)
