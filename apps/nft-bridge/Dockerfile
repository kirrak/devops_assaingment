# Use the official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json from the correct path
COPY ./apps/nft-bridge/package*.json ./

# Install dependencies
RUN npm install

# Expose the port your application will run on (replace with actual port if different)
EXPOSE 3000

# Command to run your app
CMD ["npm", "start"]
