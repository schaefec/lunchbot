FROM golang:alpine AS builder

RUN mkdir /build
ADD . /build
WORKDIR /build

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o lunchbot .


FROM scratch
COPY --from=builder /build/lunchbot /app/
WORKDIR /app
CMD ["./lunchbot"]
