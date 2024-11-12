FROM nginx:alpine

# Copy the HTML file to the server
COPY index.html /usr/share/nginx/html

# Expose port 80
EXPOSE 80