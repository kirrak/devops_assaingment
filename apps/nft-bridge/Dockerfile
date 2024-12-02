# Use Node.js version 16 as the base image (adjust if needed)
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY ./apps/nft-bridge/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY ./apps/nft-bridge .

# Expose the application's port (replace 3000 with the correct port if different)
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
