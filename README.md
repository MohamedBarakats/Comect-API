# Comect API Service

Service to return memes Images and Videos
## Setup

To get the comect_api_service to run locally, install the following:

* ruby 2.7.1
* postgresql


The commands you need to run could be found on ``` .github/workflows/ci.yml ``` 

```sh
$ cd commect_api
$ cp config/database.yml.github-actions config/database.yml
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:schema:load
$ bundle exec rspec  --require rails_helper
$ bundle exec rubocop
$ rails s
```
If  bundle install throughs this error
```MySQL Install: ERROR: Failed to build gem native extension```
You must install openssl and run this commands
```sh
$ brew install openssl
$ bundle config --global build.mysql2 --with-opt-dir="$(brew --prefix openssl)"
$ bundle install
```
## API Documentation

We use the [swagger specification](https://swagger.io/specification/) to document our API.
The API schema is in the `doc/api/commect_api.yml` file.
