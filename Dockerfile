FROM golang:1.22
COPY . /src/
WORKDIR /src/
RUN make clean \
  && make test \
  && make

FROM ubuntu:jammy
RUN apt update && apt upgrade -y
COPY --from=0 /src/event-forwarder-gelf /event-forwarder-gelf
ENTRYPOINT ["/event-forwarder-gelf"]
