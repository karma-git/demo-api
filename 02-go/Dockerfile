FROM golang:1.21-alpine3.18 AS build

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

COPY . /go

RUN set -eux \
    && unset GOPATH \
    && go build .

FROM scratch AS final

COPY --from=build /go/main /main

EXPOSE 8080

CMD ["/main"]
