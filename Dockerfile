# Stage 1: Build the TypeScript code
FROM node:14 AS build

# Set the working directory in the build stage
WORKDIR /usr/src/app

# Copy package.json and install all dependencies (including devDependencies)
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the TypeScript code
RUN npm run build

# Stage 2: Create the final image without devDependencies
FROM node:14

# Set the working directory in the final image
WORKDIR /usr/src/app

# Copy only the production dependencies
COPY package*.json ./
RUN npm install --production

# Copy the compiled code from the build stage
COPY --from=build /usr/src/app/dist ./dist

# Expose the port that the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
