# Simple sharing youtube video

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.7.2

* Rails version
  6.0.4

* System dependencies
  - 4GB RAM
  - 2vCPU

* How to run the test suite
  ```ruby
  $ bundle install
  $ RACK_ENV=test bundle exec rspec
  ```

* How to run application on localhost
  - After you run test and all case passed
  - Make sure you have mongodb running on local
  - Edit file `mongoid.yml` for your database connection
  - Run
  ```ruby
  $ bundle install
  $ rails server
  ```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* TODO
  - Pagination when load home page
  - Inifinity load more
  - Localized
  - Custom messages error Mongoid validate
  - Unvote / undownvote
  - Refactor: use ComponentsDidUpdate for fecth data movies from API instead of get from DOM content
...
