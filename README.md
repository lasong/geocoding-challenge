# Geocoding App

A small rails geocoding app.

## Prerequisites
- Ruby version 3.3.1
- Docker

## Setup
- Clone repository: `git clone git@github.com:lasong/geocoding-challenge.git`
- Start the application with Docker: `docker compose up`. The web app image will be built and the database setup the first time it is run.

## Running the app
With docker running, go to http://localhost:3000. You will see the login page and the register link at the bottom.

To stop docker, use `Ctrl-C`. To remove the images, run `docker compose down`.

## Running tests
- Run `docker compose exec web bin/rspec spec` to run tests.
- RUn `docker compose exec web bin/rubocop` to run linting.
