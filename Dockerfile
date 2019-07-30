FROM ejectedspace/pandoc-builder as builder
WORKDIR /build
COPY . .
RUN make build

FROM ejectedspace/saneginx
COPY --from=builder /build/dist/ /usr/share/nginx/html/
