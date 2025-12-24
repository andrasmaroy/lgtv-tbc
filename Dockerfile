FROM golang:1.15 AS builder

WORKDIR /app
COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o lgtv-tbc .

FROM alpine:latest

WORKDIR /app/
COPY --from=builder /app/lgtv-tbc ./

EXPOSE 8765
ENTRYPOINT ["./lgtv-tbc"]
CMD ["-addr", ":8765"]
