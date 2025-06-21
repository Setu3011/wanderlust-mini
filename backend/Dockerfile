FROM node:20

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app code
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
