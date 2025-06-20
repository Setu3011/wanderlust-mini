# === Final Dockerfile ===
FROM node:20

# Set working directory
WORKDIR /app

# Copy backend code including node_modules
COPY backend/ .

# Skip npm install to avoid resource usage on t2.micro
# Ensure node_modules is already in the backend folder

CMD ["node", "index.js"]
