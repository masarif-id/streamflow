# Gunakan image Node.js versi 18 (atau 16+)
FROM node:18-slim

# Install ffmpeg and build tools for native modules
RUN apt-get update && apt-get install -y \
    ffmpeg \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Remove build tools to reduce image size (optional)
RUN apt-get purge -y build-essential python3 && apt-get autoremove -y

# Copy seluruh source code
COPY . .

# Buat folder yang dibutuhkan (jika belum ada)
RUN mkdir -p db logs public/uploads/videos public/uploads/thumbnails

# Expose port (default 7575, bisa diubah via .env)
EXPOSE 7575

# Jalankan aplikasi
CMD ["npm", "start"]