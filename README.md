Participate is a democratic participation plaftorm, based on [LiquidFeedback](http://liquidfeedback.org), the open source system used at the Pirate Party for its internal decision making and policy creation, and on its [principles](http://principles.liquidfeedback.org).

Development is in its early stages.

The platform is made up of a ruby API built on [Grape](https://github.com/intridea/grape), the codebase for which you'll find in this repo, and a [Ember.js](http://emberjs.com) front-end app that [lives at another repo](https://github.com/oliverbarnes/participate-frontend) and gets run separately. 

The API has endpoints essentially CRUDing the basic domain models (like Initiative, Vote and Delegation), and work will start soon on the core logic (such as Initiative states/phases, calculating voting weight, and harmonic ordering) implementing LF's algorithms. Work on the frontend app has just started.

#### Poking around

To run the API, check the generated API docs and test the current state:

```
git clone https://github.com/oliverbarnes/participate.git
cd participate
bundle install
bundle exec rackup
open http://localhost:9292/docs
```

And use the example curl commands to test the endpoints.

#### Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) guide and the [CHANGELOG](CHANGELOG.md).