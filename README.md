Participate is a democratic participation plaftorm, based on [LiquidFeedback](http://liquidfeedback.org), the open source system used at the Pirate Party for its internal decision making and policy creation, and on its [principles](http://principles.liquidfeedback.org).

## State of development and technology stack

Development is in its early stages.

The platform is made up of a ruby API built on [Grape](https://github.com/intridea/grape), whose codebase you'll find in this repo, and a [Ember.js](http://emberjs.com) front-end app that [lives at another repo](https://github.com/oliverbarnes/participate-frontend).

The API has endpoints essentially CRUDing the basic domain models (like Initiative, Vote and Delegation), and work will start soon on the core logic (such as Initiative states/phases, calculating voting weight, and harmonic ordering) implementing LF's algorithms. Work on the frontend app has just started.

## Getting started on development for the API

- Fork this repo
- Bundle
- Install MongoDB and start it

```
$ brew install mongodb
$ mongod --logpath mongo.log &
```

- Start [Guard](https://github.com/guard/guard)

```
$ guard
```

- Hit Enter/Return to run the test suite.

Acceptance tests use the [RSpec API Documentation](https://github.com/zipmark/rspec_api_documentation) gem, which generates docs that get served online in parallel with the API. Unit tests use [RSpec](http://rspec.info). Development is fully test-driven.








