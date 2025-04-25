# Use a lightweight web server as base image
FROM nginx:alpine

# Copy the static files to nginx's serve directory
COPY index.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
