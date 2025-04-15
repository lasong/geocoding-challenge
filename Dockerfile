FROM ruby:3.3.1-slim

# Install packages
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
# Prepare workdir and Ruby deps
ENV APP_HOME /app
WORKDIR $APP_HOME

# Install gems
COPY Gemfile Gemfile.lock $APP_HOME
RUN bundle install

# Copy app code
COPY . $APP_HOME

ENTRYPOINT ["/app/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
