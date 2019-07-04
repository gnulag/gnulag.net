FROM fedora as builder
WORKDIR /build
COPY . .
RUN dnf install -y git sassc pandoc perl make
RUN make build

FROM ejectedspace/saneginx
COPY --from=builder /build/dist/ /usr/share/nginx/html/
