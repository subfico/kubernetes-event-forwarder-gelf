FROM golang:1.25.3
COPY . /src/
WORKDIR /src/
RUN go get golang.org/x/net@v0.33.0
RUN go get github.com/golang/glog@v1.2.4
RUN go get google.golang.org/protobuf@v1.33.0

RUN make clean \
  && make test \
  && make

FROM ubuntu:jammy
RUN apt update && apt upgrade -y
COPY --from=0 /src/event-forwarder-gelf /event-forwarder-gelf
ENTRYPOINT ["/event-forwarder-gelf"]
