FROM ruby:3.3-rc-alpine3.18

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

COPY ./Gemfile /home/app

WORKDIR /home/app

RUN apk add --no-cache --virtual .build-deps \
  build-base==0.5-r3 \
  && gem install bundle \
  && bundle install --no-cache \
  && apk del .build-deps

COPY ./ /home/app/

USER app

EXPOSE 8083

ENTRYPOINT ["/usr/bin/ruby"]
CMD ["main.rb"]
