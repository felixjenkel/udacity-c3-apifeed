# Use NodeJS base image
FROM node:lts

# Create app directory
WORKDIR /usr/src/app

# Copy App Source
COPY . .

# Install dependencies
RUN npm install
RUN npm run build

# Bind the port that the image will run on
EXPOSE 8080

# Define the Docker image's behavior at runtime
CMD ["node", "./www/server.js"]
