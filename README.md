# Simple sharing youtube video

## Mini app Funny Movies sharing Youtube videos
* Overview
  - A ruby on rails application
  - Use RoR for logic backend and React components for frontend
  - Current version included functions:
    + Register new user with email, password
    + Forgot password (optional, send email reset password is not availabe)
    + Sign in / Sign out
    + View list of shared videos
    + Share Youtube video from URL (requires login)
    + Upvote / Downvote (requires login)
  - Unit test and integration test implementation

* Use case
  Comming soon...


## Things you may want to cover:

* Ruby version
  2.7.2

* Rails version
  6.0.4

* Mongo database version
  4.0.9

* Dependencies
  - Google Chrome
  - ChromeDriver
  - Yarn
  - Webpack
  - Docker & Docker Compose

* How to run the test suite
  - Make sure your OS installed Google Chrome browser
  - Run test unit
  ```bash
  $ bundle install
  $ RACK_ENV=test bundle exec rspec
  ```
  - After run test unit done, open `coverage` in path:
  ```bash
  <YOUR_APP_DIR>/coverage/index.html
  ```

* How to run application on localhost
  - After you run test and all case passed
  - Make sure you have MongoDB running on local
  - Edit file `config/application.yml` for your database connection
  - Run
  ```ruby
  $ bundle install
  $ yarn install
  $ rails server
  ```

  - Open URL: http://localhost:3000

* How to run application on docker
  - After you run test and all case passed
  - Make sure Docker enginee running and docker compose installed
  - Run
  ```bash
  $ docker-compose up --build
  ```

  - Open URL: http://localhost:3000

* Deployment instructions
  - URL demo: 

## TODO
  - Pagination when load home page
  - Inifinity load more
  - Localization (I18n)
  - Custom messages error Mongoid validate
  - Undo vote / Undo downvote
  - Refactor: use ComponentsDidUpdate for fecth data movies from API instead of get from DOM
  - Use cucumber for BDD
  - ...
