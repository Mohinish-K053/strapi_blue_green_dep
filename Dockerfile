# --- Builder Stage ---
FROM node:18-bullseye AS builder

# Install dependencies needed for native builds
RUN apt-get update && \
    apt-get install -y python3 make g++ git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

# Only copy package files first (for better layer caching)
COPY package*.json ./

# Install dependencies inside Docker
RUN npm install

# Then copy the rest of the app
COPY . .

# Build admin panel & backend
RUN npm run build

# --- Final Runtime Stage ---
FROM node:18-bullseye

# Install only required runtime libs (e.g., for sharp)
RUN apt-get update && apt-get install -y libvips-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

# Copy built app and installed modules from builder
COPY --from=builder /opt/app .

# Set correct owner for non-root user (optional)
RUN chown -R node:node /opt/app
USER node

EXPOSE 1337

CMD ["npm", "run", "start"]
