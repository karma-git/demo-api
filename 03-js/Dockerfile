FROM alpine:3.14.10

RUN apk add --no-cache \
    nodejs~=14.21.3 \
    npm~=7.17.0

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

WORKDIR /home/app

COPY ./ /home/app

RUN npm install

USER app

EXPOSE 8080

ENTRYPOINT ["/usr/bin/node"]
CMD ["main.js"]
