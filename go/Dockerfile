FROM golang:1.17.2-alpine3.14 AS build

ARG CGO_ENABLED=0
ARG GOOS=linux 
ARG GOARCH=amd64

COPY . /go

RUN set -eux \
    && unset GOPATH \
    && go build .

FROM scratch AS final

COPY --from=build /go/main /main

CMD ["/main"]
