# Running

```
$ bundle install
$ bundle exec foreman start
```

# Wishlist
* There should be one status per build with multiple states (Cloning, Building, Testing)

* Config file reader for .docking_station.yml files
    * Decide whether to run a server (`docker run`) first with config file inside repo
    * We should pull test scripts from a config file inside the repo

* TestWorker should take a command to run (or a string identifier from the config file) so we can kick off multiple tests in parallel

* Build/test output is updated live in the database, but the page should be updated as well (remote: true?)

* An xunit parser with highlighting to get failed tests (can this be done live with nosetests/rspec? I don't think it can, so it'd have
                                                         to be parsed after the run is done.)

* It's likely cleaner to just create a new build on rebuild and redirect (prompt for redirect? "There's a newer build here.")
    * That keeps our historical output for builds

* Ability to schedule recurring builds
    * Integration tests (know when a service changes their contract)

* Accept GitHub webhooks and automatically create projects/builds
    * Git clone project to temp directory
    * Read in .docking_station.yml
    * Set up project/build with options
    * Set statuses for GitHub projects
    
