# Use the lightweight Nginx Alpine image
FROM nginx:alpine

# Copy all static assets (HTML, CSS, JS) into the Nginx default public directory
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80