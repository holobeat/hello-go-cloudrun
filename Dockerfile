FROM golang:1.25.5-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/server /app/server

ENV PORT=8080

EXPOSE 8080

CMD ["/app/server"]

