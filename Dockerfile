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

# Create a script to modify the index.html file
RUN echo '#!/bin/bash \n\
sed -i "s|<title>LibreChat</title>|<title>Berget AI</title>|g" /app/client/dist/index.html \n\
sed -i "s|<meta name=\"description\" content=\"LibreChat - An open source chat application with support for multiple AI models\" />|<meta name=\"description\" content=\"Berget AI - Ingen data lämnar Sverige 🇪🇺 GDPR säkert\" />|g" /app/client/dist/index.html \n\
sed -i "s|<html lang=\"en-US\">|<html lang=\"sv-SE\">|g" /app/client/dist/index.html \n\
sed -i "s|backgroundColor = \"#0d0d0d\";|backgroundColor = \"#1a1a1a\";|g" /app/client/dist/index.html \n\
sed -i "s|#loading-container {|#loading-container {\n          background-image: linear-gradient(to bottom, rgba(229, 221, 213, 0.02) 1px, transparent 1px), linear-gradient(to right, rgba(229, 221, 213, 0.02) 1px, transparent 1px);\n          background-size: 24px 24px;|g" /app/client/dist/index.html' > /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

# Set the entrypoint to run our script and then start the server
ENTRYPOINT ["/bin/bash", "-c", "/docker-entrypoint.sh && node /app/api/server/index.js"]
