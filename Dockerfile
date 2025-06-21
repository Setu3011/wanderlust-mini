# Use Node.js LTS base image
FROM node:20

# Set working directory
WORKDIR /app

# Copy backend code
COPY backend/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the backend files
COPY backend/ .

# Copy the frontend (public) directory
COPY frontend ./public

# Expose port
EXPOSE 3000

# Start the app (you must have index.js in /app)
CMD [ "node", "index.js" ]
