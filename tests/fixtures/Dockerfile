FROM ruby:3.4-alpine

WORKDIR /app
COPY . .
RUN bundle install

CMD ["bundle", "exec", "rails", "server"]
