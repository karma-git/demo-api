FROM ruby:3.3-rc-alpine3.18

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

RUN apk add --no-cache --virtual .build-deps \
  build-base==0.5-r3 \
  && gem install bundle:0.0.1 \
  && bundle install --no-cache \
  && apk del .build-deps

USER app

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/ruby"]
CMD ["main.rb"]
