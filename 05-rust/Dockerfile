FROM rust:alpine3.18 AS build

COPY ./ /tmp

WORKDIR /tmp

RUN apk add --no-cache build-base~=0.5

RUN cargo build

FROM scratch AS final

COPY --from=build /tmp/target/debug/rust /main

EXPOSE 8080

CMD ["/main"]
