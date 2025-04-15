# Geocoding App

A small rails geocoding app.

## Prerequisites
- Ruby version 3.3.1
- Docker

## Setup
- Clone repository: `git clone git@github.com:lasong/geocoding-challenge.git`
- Go to the app folder and start the application with Docker: `docker compose up`. The web app image will be built and the database will be setup the first time it is run.

## Running the app
With docker running, go to http://localhost:3000. You will see the login page and the register link at the bottom.

To stop docker, use `Ctrl-C`.

You can also start the app in the background by running `docker compose up -d`. In this case, run `docker compose stop` to stop docker.

To remove the running containers, run `docker compose down`.

## Running tests
- Run `docker compose exec web bin/rspec spec` to run tests.
- RUn `docker compose exec web bin/rubocop` to run linting.
