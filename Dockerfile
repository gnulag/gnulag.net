FROM debian as builder
WORKDIR /build
COPY . .
RUN apt-get update && apt-get install -y git sassc pandoc perl make
RUN make build

FROM ejectedspace/saneginx
COPY --from=builder /build/dist/ /usr/share/nginx/html/
