FROM nginx:alpine

COPY Blog/html /usr/share/nginx/html

EXPOSE 80
