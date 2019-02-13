FROM node as builder
WORKDIR /build
COPY . .
RUN npm install -g vuepress
RUN vuepress build

FROM ejectedspace/saneginx
COPY --from=builder /build/.vuepress/dist/ /usr/share/nginx/html/
