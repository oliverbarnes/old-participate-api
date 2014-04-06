Ruby port of [LiquidFeedback](http://liquidfeedback.org), the platform used in the Pirate Party's internal, radically democratic decision making, proposition/initiative development and policy drafting. It's also used by other institutions of different kinds, and even businesses. 

It's in the forefront of digital democracy platforms, implementing the concept of [liquid democracy](http://en.wikipedia.org/wiki/Delegative_democracy) as a path to solve the huge short-comings of representative democracy.

The port is in its early stages.

This project started as a way to learn more about liquid democracy itself, and how they implement it, while I read the recently published [Principles of LiquidFeedback book](http://principles.liquidfeedback.org), out of an interest in online participative platforms and their potential for political change.

Now beginning to take shape as an open source project aiming to be applicable down the line, and to make LiquidFeedback available for rubyists interested in it.

Shooting for a easily extensible and customizable code-base, a user-friendly default web interface, while making it easy to plug other front-end implementations, web and/or mobile.

### Plan and stack

The plan is to build an API and a reference Ember front-end app bundled with it. 

The API is in early progress, being built on [Grape](https://github.com/intridea/grape) and Mongodb ([Mongoid](http://mongoid.org/en/mongoid/index.html)).

I'm using the [Rspec API Documentation](https://github.com/zipmark/rspec_api_documentation) gem for acceptance testing and, well, API documentation (it gets generated and then served online in parallel with the API), and Rspec for good old unit tests. Development is fully test-driven.

Implementation is loosely based on LiquidFeedback's [API documentation](http://dev.liquidfeedback.org/trac/lf/wiki/API) and [source](http://www.public-software-group.org/mercurial/lfapi), and on the [source for its Core application](http://dev.liquidfeedback.org/trac/lf/wiki/Core). 

### Contributing

Contributors would be most welcome :)

If you're interested, go right ahead and open an issue or a pull request to get the ball rolling. Or contact me at oliverbwork@gmail.com.

