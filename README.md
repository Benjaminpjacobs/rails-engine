# Rails Engine

A sales data api built with Rails 5.1 and Ruby 2.4.1. This engine serves up record, relationship and business intelligence JSON for the included dataset.

1. Clone down this repo
2. Clone down [rails-engine spec harness](https://github.com/turingschool/rales_engine_spec_harness)
3. Navigate into the railes-engine directory ```cd rails-engine```
4. ```bundle```
5. Create database ```rake db:setup```
6. Import CSV files ```rake import:all```
7. Run the server ```rails server```
8. In another terminal window navigate into the rails-engine spec harness directory
9. ```bundle``` 
1.```rake``` to run test suite.

Interact with [Swagger UI](https://sales-engine-api.herokuapp.com/apidocs/index.html) for this API.
