# Use an official Node runtime as the builder stage
FROM node:14-alpine as builder

# Set the working directory in the Docker image
WORKDIR /app

# Copy package.json and package-lock.json into the Docker image
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Copy the rest of your app's source code into the Docker image
COPY . .

# Build the app
RUN npm run build

# Start the app
FROM node:14-alpine
WORKDIR /app
COPY --from=builder /app .
EXPOSE 8000
CMD [ "npm", "run", "serve" ]