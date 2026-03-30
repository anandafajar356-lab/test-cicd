# Use the lightweight Nginx Alpine image
FROM nginx:alpine

# Copy your local html file into the Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80