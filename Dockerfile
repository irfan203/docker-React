FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY . .
RUN npm run build

FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
