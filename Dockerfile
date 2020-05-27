FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx

COPY /nginx/nginx.conf /etc/nginx/default.conf 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html