FROM golang:1.20-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add --no-cache \
    libpcap-dev \
    gcc \
    musl-dev upx

WORKDIR /app

RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct
CMD sh -c "go env;CGO_ENABLED=1  go build -ldflags '-s -w -extldflags \"-static\"'
