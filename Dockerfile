# Declare the base image
FROM nginx:alpine

# Set work directory
WORKDIR /usr/share/nginx/html

# Copy files (correct syntax: COPY <src> <dest>)
COPY ./webapp /usr/share/nginx/html

# Expose port
EXPOSE 80

# Command
CMD ["nginx", "-g", "daemon off;"]