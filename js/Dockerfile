FROM alpine:3.14

RUN apk add --no-cache \
    nodejs~=14.18 \
    npm~=7.17

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

WORKDIR /home/app

USER app

COPY ./ /home/app

RUN npm install

EXPOSE 8082

ENTRYPOINT ["/usr/bin/node"]
CMD ["main.js"]
