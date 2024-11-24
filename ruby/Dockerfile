FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

COPY . .

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "padrino", "start", "-p", "3000"]
