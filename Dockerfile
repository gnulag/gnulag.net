FROM ejectedspace/pandoc-builder as builder
WORKDIR /build
COPY . .
RUN make build

FROM nginx
COPY --from=builder /build/dist/ /usr/share/nginx/html/
RUN echo " \
server { \
    listen       80; \
    listen       [::]:80; \
    server_name  localhost; \
\
    location / { \
        root   /usr/share/nginx/html; \
        index index.html; \
    } \
}" > /etc/nginx/conf.d/default.conf
