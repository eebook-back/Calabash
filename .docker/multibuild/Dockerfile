FROM golang:1.8.3 as builder
WORKDIR /go/src/github.com/AliyunContainerService/fluentd-pilot/
COPY . /go/src/github.com/AliyunContainerService/fluentd-pilot/
RUN CGO_ENABLED=0 GOOS=linux go build -o xxhzdy ./main.go

FROM alpine:3.5

RUN apk update && apk upgrade && \  
  apk add ruby-json ruby-irb && \
  apk add build-base ruby-dev && \
  apk add python && \
  apk add lsof && \
  apk add ca-certificates wget && \
  gem install fluentd -v "~> 0.12.0" --no-ri --no-rdoc && \
  gem install fluent-plugin-elasticsearch --no-ri --no-rdoc && \
  gem install gelf -v "~> 3.0.0" --no-ri --no-rdoc && \
  gem install aliyun_sls_sdk -v ">=0.0.9" --no-ri --no-rdoc && \
  gem install remote_syslog_logger -v ">=1.0.1" --no-ri --no-rdoc && \
  gem install fluent-plugin-remote_syslog -v ">=0.2.1" --no-ri --no-rdoc && \
  gem install fluent-plugin-kafka --no-ri --no-rdoc && \
  apk del build-base ruby-dev && \
  rm -rf /root/.gem

COPY plugins/ /etc/fluentd/plugins/

VOLUME /etc/fluentd/conf.d

COPY fluentd.tpl entrypoint config.default /pilot/
COPY --from=builder /go/src/github.com/AliyunContainerService/fluentd-pilot/pilot /pilot/
VOLUME /pilot/pos

EXPOSE 24224
WORKDIR /pilot/
#CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
CMD /pilot/entrypoint
