Ruby port of [LiquidFeedback](http://liquidfeedback.org).

Very early stage. 

Started as a way to learn how it implements [delegative democracy](http://en.wikipedia.org/wiki/Delegative_democracy), while I read the recently published [Principles of LiquidFeedback book](http://principles.liquidfeedback.org), out of an interest in online participative platforms and their potential for political change.

Now beginning to take shape as a long-term open source project, aiming for real applicability down the line, and available to the wider ruby community to use and extend. 

### General direction and tech info

The plan is to build an API and an Ember app to go with it, as a reference front-end implementation. 

The API is in early progress, being built on [Grape](https://github.com/intridea/grape) and Mongodb ([Mongoid](http://mongoid.org/en/mongoid/index.html)).

Using [Rspec API Documentation](https://github.com/zipmark/rspec_api_documentation) for acceptance testing and generating the api docs, and Rspec for unit tests. 

The implementation is loosely based on LiquidFeedback's [API documentation](http://dev.liquidfeedback.org/trac/lf/wiki/API) and [source](http://www.public-software-group.org/mercurial/lfapi), and the [source for its Core application](http://dev.liquidfeedback.org/trac/lf/wiki/Core).

Shooting for a clean, modular code-base, and a more user-friendly interface on the front-end.

### Contributing

Contributors would be most welcome :)

If you're interested, go right ahead and open an issue or a pull request to get the ball rolling. Or contact me at oliverbwork@gmail.com.

