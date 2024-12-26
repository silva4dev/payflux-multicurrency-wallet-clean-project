FROM golang:1.20

RUN apt update && \
    apt install -y wget netcat-traditional && \
    wget -q -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/v2.2.3/wait-for && \
    chmod +x /usr/bin/wait-for

WORKDIR /app/

COPY . . 

EXPOSE 8080

RUN apt-get update && apt-get install -y librdkafka-dev

CMD ["sh", "-c", "chmod +x /app/entrypoints/docker-entrypoint.sh && /usr/bin/wait-for wallet-mysql:3306 -t 40 -- /app/entrypoints/docker-entrypoint.sh"]
