# Use the official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json from the build context
COPY apps/nft-bridge/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code from the build context
COPY apps/nft-bridge/ ./

# Expose the port your application will run on (replace 3000 if different)
EXPOSE 3000

# Command to run your app
CMD ["npm", "start"]
