FROM ejectedspace/pandoc-builder as builder
WORKDIR /build
COPY . .
RUN make build

FROM nginx
COPY --from=builder /build/dist/ /usr/share/nginx/html/
