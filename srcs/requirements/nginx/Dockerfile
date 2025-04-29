FROM alpine:3.20

# Install nginx
RUN apk add --no-cache nginx

# Copy Configuration File & Cert Files
COPY ./conf/rules /etc/nginx/http.d/
COPY ./conf/ssl /etc/nginx/ssl/

# Expose the port (HTTPS ONLY)
EXPOSE 433 

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]