FROM golang:1.23 AS base

FROM base AS builder
WORKDIR /app 

COPY go.mod go.sum .
RUN go mod download && go mod verify

COPY . .

RUN go build -o app .

FROM base AS runner
WORKDIR /app

COPY --from=builder app .

CMD ["app"]
