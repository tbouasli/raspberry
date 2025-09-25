FROM nginx:latest

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create log directories
RUN mkdir -p /var/log/nginx

# Expose ports
EXPOSE 80 25565