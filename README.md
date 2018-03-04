# MovieDB

This is an IMDB clone, API only. There are still some rough edges and things to be done.

Most important issues are commented as `TODO`

## Stack

- Rails 5
- Ruby 2.5.0
- PostgreSQL 10.3
- Sequel
- rom-rb

## Authentication

Authentication assumes that frontend side of the application will authenticate users by using external service like OAuth or Auth0 and will send to the API a JWT token with encrypted user information.
JWT token should be passed through headers.

## Setup

```
bundle install
```

## Managing DB

```
rake db:create
rake db:migrate
rake db:drop
rake db:test:prepare
```

## Testing

Test specs are written to test classes in isolation, mocking everything that's possible.
There are also `integration` tests in `spec/integration` that test the entire app.

```
bundle exec rspec
```

## To be done
- [ ] CRUD for users
- [ ] Update and Destroy for movie ratings
- [ ] Some test refactoring
- [ ] Pagination for movies
- [ ] Sidekiq for calculating new rating
