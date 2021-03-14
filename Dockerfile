FROM golang:alpine as build

RUN apk update && \
    apk add git && \
    mkdir -p /usr/src/ && \ 
    cd /usr/src && \
    git clone https://github.com/a1comms/freepbx-ldap && \
    cd freepbx-ldap && \
    git checkout 942d344 && \
    go build

FROM lsiobase/alpine:3.13

RUN mkdir -p /usr/local/bin
COPY --from=build /usr/src/freepbx-ldap/freepbx-ldap /usr/local/bin/
RUN chmod +x /usr/local/bin/freepbx-ldap
COPY root/ /

EXPOSE 10389
