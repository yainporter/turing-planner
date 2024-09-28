FROM ruby:3.2.5
# Use the official Ruby image
# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  zsh \
  curl \
  nodejs \
  nano \
  postgresql-client \
  build-essential \
  libpq-dev \
  git

# Set the working directory
WORKDIR /app
# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the application code
COPY . .

# Precompile assets (if using Rails)
RUN bundle exec rake assets:precompile || (echo "Failed to precompile assets" && exit 1)
# Script to make sure the server doesn't auto-exit
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# Expose port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
