Participate is a democratic participation plaftorm, based on [LiquidFeedback](http://liquidfeedback.org), the open source system used at the Pirate Party for its internal decision making and policy creation, and on its [principles](http://principles.liquidfeedback.org).

## State of development and technology stack

Development is in its early stages.

The platform is made up of a ruby API built on [Grape](https://github.com/intridea/grape), the codebase for which you'll find in this repo, and a [Ember.js](http://emberjs.com) front-end app that [lives at another repo](https://github.com/oliverbarnes/participate-frontend) and gets run separately. 

The API has endpoints essentially CRUDing the basic domain models (like Initiative, Vote and Delegation), and work will start soon on the core logic (such as Initiative states/phases, calculating voting weight, and harmonic ordering) implementing LF's algorithms. Work on the frontend app has just started.

If you're interested in contributing, please see the[CONTRIBUTING](CONTRIBUTING.md) guide and the [CHANGELOG](CHANGELOG.md).