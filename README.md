# Rails Engine

A sales data api built with Rails 5.1 and Ruby 2.4.1. This engine serves up record, relationship and business intelligence JSON for the included dataset.

* Clone down this repo
* Clone down [rails-engine spec harness](https://github.com/turingschool/rales_engine_spec_harness)
* Navigate into the railes-engine directory ```cd rails-engine```
* ```bundle```
* Create database ```rake db:setup```
* Import CSV files ```rake import:all```
* Run the server ```rails server```
* In another terminal window navigate into the rails-engine spec harness directory
* ```bundle``` 
* ```rake``` to run test suite.

Interact with [Swagger UI](https://sales-engine-api.herokuapp.com/apidocs/index.html) for this API.
