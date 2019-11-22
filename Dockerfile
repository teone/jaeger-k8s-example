FROM golang:1.13-stretch as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o jaeger-k8s-example main.go

CMD ["./jaeger-k8s-example"]