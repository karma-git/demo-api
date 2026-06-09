FROM node:22-alpine3.20

RUN npm install -g pnpm

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

RUN pnpm install

USER app

EXPOSE 8080

ENTRYPOINT ["node"]
CMD ["main.js"]
