Contributing
============

So far this is a one-man project, and new contributions will be greatly appreciated. You're welcome to submit [pull requests](https://github.com/oliverbarnes/participate/pulls), [propose features and discuss issues](https://github.com/oliverbarnes/participate/issues). When in doubt, ask a question in the [Participate App Google Group](https://groups.google.com/forum/#!forum/participate-app).

#### Fork the Project

Fork the [project on Github](https://github.com/oliverbarnes/participate) and check out your copy.

```
git clone https://github.com/contributor/participate.git
cd participate
git remote add upstream https://github.com/oliverbarnes/participate.git
```

#### Ruby version and database

Install Ruby 2.1.1 if you don't have it yet

```
rvm install 2.1.1
```

(Or use whatever ruby version manager you prefer. There's a [.ruby-version](.ruby-version) for the project that should work with any of them)

Install MongoDB if you don't have it yet as well and start it up.

```
brew install mongodb
mongod --logpath mongo.log &
```

#### Bundle install and run tests

Ensure that dependencies are installed and tests run and pass.

```
bundle install
guard
```

(Hit Enter/Return to get Guard to run the test suite after starting up)

#### Start the app and check the API docs

To run the app, open a new terminal tab or window and run

```
bundle exec rackup
```

The app will go up on 

[http://localhost:9292/](http://localhost:9292/). 

The generated API docs can be seen at

[http://localhost:9292/docs/](http://localhost:9292/docs/)

To manually test the API, use the `curl` command examples.

If you're curious about how this works, check out [Rspec Api Documentation](https://github.com/zipmark/rspec_api_documentation) and [Raddocs](https://github.com/smartlogic/raddocs/).

#### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

#### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add to [spec/](spec/).

I also appreciate pull requests that highlight or reproduce a problem, even without a fix.

#### Write Code

Implement your feature or bug fix. Please be sure to submit clean, well refactored code.

#### Generate Documentation for API changes

If endpoints have been added or changed, regenerate the API docs

```
rspec spec/acceptance --format RspecApiDocumentation::ApiFormatter
```

#### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md). Make it look like every other line, including your name and link to your Github account.

#### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

#### Push

```
git push origin my-feature-branch
```

#### Make a Pull Request

Go to https://github.com/contributor/participate and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed daily on weekdays.

If you're new to Pull Requests, check out the [Github docs](https://help.github.com/articles/using-pull-requests)

#### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

#### Update CHANGELOG Again

Update the [CHANGELOG](CHANGELOG.md) with the pull request number. A typical entry looks as follows (fake entry).

```
* [#123](https://github.com/oliverbarnes/participate/pull/123): Add vote notifications - [@contributor](https://github.com/contributor).
```

Amend your previous commit and force push the changes.

```
git commit --amend
git push origin my-feature-branch -f
```

#### Be Patient

It's likely that your change will not be merged and that I will ask you to do more, or fix seemingly benign problems. Hang on there!

#### Thank You

Again, any contribution small or big is greatly appreciated. Thank you.
