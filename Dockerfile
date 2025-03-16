FROM ghcr.io/danny-avila/librechat:latest

# Create necessary directories
RUN mkdir -p /app/client/dist/assets/fonts

# Copy our custom assets to the dist directory
COPY assets/berget-icon-black-16x16.png /app/client/dist/assets/favicon-16x16.png
COPY assets/berget-icon-black-32x32.png /app/client/dist/assets/favicon-32x32.png
COPY assets/berget-icon-black-128x128.png /app/client/dist/assets/apple-touch-icon-180x180.png
COPY assets/berget-icon-black.svg /app/client/dist/assets/
COPY assets/berget-icon-white.svg /app/client/dist/assets/

# Copy font files
COPY assets/fonts/dm-sans.css /app/client/dist/assets/fonts/
COPY assets/fonts/dm-sans-regular.woff2 /app/client/dist/assets/fonts/
COPY assets/fonts/dm-sans-500.woff2 /app/client/dist/assets/fonts/
COPY assets/fonts/dm-sans-700.woff2 /app/client/dist/assets/fonts/
COPY assets/fonts/ovo.css /app/client/dist/assets/fonts/
COPY assets/fonts/ovo-regular.woff2 /app/client/dist/assets/fonts/

# Copy our manifest file
COPY manifest.webmanifest /app/client/dist/manifest.webmanifest

# Copy the script to modify the index.html file
COPY modify-index.sh /app/modify-index.sh
RUN chmod +x /app/modify-index.sh && /app/modify-index.sh
