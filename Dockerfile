FROM golang:1.17-alpine AS build

WORKDIR /go/src/guild-expirations

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o guild-expirations .

FROM alpine:latest

WORKDIR /opt/guild-expirations

COPY --from=build /go/src/guild-expirations .

EXPOSE 3000

CMD ["./main"]