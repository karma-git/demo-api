FROM php:fpm-alpine3.18

ENV PORT=8080

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

COPY ./ /home/app

WORKDIR /home/app

RUN apk add --no-cache composer~=2.6 \
  && composer install

USER app

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/php"]
# CMD ["-S", "0.0.0.0:${PORT}", "-t", "."]  # for some reason this is not working
CMD ["-S", "0.0.0.0:8086", "-t", "."]
