FROM alpine:3.14

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

RUN apk add --no-cache \
    ruby~=2.7.5 \
    ruby-json~=2.7.5 \
    ruby-etc~=2.7.5 \
  && gem install bundle \
  && apk add --no-cache --virtual .build-deps \
    ruby-dev~=2.7.5 \
    libffi-dev~=3.3 \
    gcc~=10.3.1 \
    g++~=10.3.1 \
    make~=4.3 \
    automake~=1.16.3 \
  && bundle install --no-cache \
  && apk del .build-deps

COPY ./ /home/app/

USER app

EXPOSE 8083

ENTRYPOINT ["/usr/bin/ruby"]
CMD ["main.rb"]
