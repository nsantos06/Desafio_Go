FROM golang:1.22.6-alpine AS build


WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY helloword.go ./
COPY go.mod ./

RUN go mod download 
RUN go build -o /server


FROM scratch
WORKDIR /
COPY --from=build /server /server
EXPOSE 8080 
ENTRYPOINT [ "/server" ]