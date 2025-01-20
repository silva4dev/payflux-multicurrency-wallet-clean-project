FROM ruby:3.1.0

RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    librdkafka-dev \
    default-mysql-client \
    curl

RUN apt update && \
    apt install -y wget netcat-traditional && \
    wget -q -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/v2.2.3/wait-for && \
    chmod +x /usr/bin/wait-for

WORKDIR /app/

COPY . . 

EXPOSE 3003

CMD ["sh", "-c", "chmod +x /app/entrypoints/docker-entrypoint.sh && /usr/bin/wait-for balances-mysql:3306 -t 40 -- /app/entrypoints/docker-entrypoint.sh"]
