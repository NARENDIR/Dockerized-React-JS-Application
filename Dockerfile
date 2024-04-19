# Base image for Node.js environment
FROM node:alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files (excluding node_modules)
COPY . .

# Switch to a slimmer runtime image
FROM node:alpine

# Copy everything from the builder stage
COPY --from=builder /app /app

# Expose port for React application (usually 3000)
EXPOSE 3000

# Set command to start the React development server
CMD [ "npm", "start" ]

