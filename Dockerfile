FROM ghcr.io/danny-avila/librechat:latest

# Create necessary directories
RUN mkdir -p /app/client/dist/assets

# Copy our custom assets to the dist directory
COPY assets/berget-icon-black-16x16.png /app/client/dist/assets/favicon-16x16.png
COPY assets/berget-icon-black-32x32.png /app/client/dist/assets/favicon-32x32.png
COPY assets/berget-icon-black-128x128.png /app/client/dist/assets/apple-touch-icon-180x180.png
COPY assets/berget-icon-black.svg /app/client/dist/assets/
COPY assets/berget-icon-white.svg /app/client/dist/assets/

# Copy our manifest file
COPY manifest.webmanifest /app/client/dist/manifest.webmanifest

# Copy the script to modify the index.html file
COPY modify-index.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Set the entrypoint to run our script and then start the server
ENTRYPOINT ["/bin/bash", "-c", "/docker-entrypoint.sh && node /app/api/server/index.js"]
