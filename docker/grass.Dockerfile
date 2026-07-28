# Use a reliable base image designed for running GUI apps in Docker
FROM jlesage/baseimage-gui:debian-12-v4

# Name the application for the web interface
ENV APP_NAME="Grass Node"

# Install dependencies required by most Desktop/Electron apps
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Download and install the official Grass Linux package directly from their servers
RUN wget -O /tmp/grass.deb "https://files.grass.io/linux/grass_latest_amd64.deb" \
    && apt-get update && apt-get install -y /tmp/grass.deb \
    && rm /tmp/grass.deb

# Create the startup script for the virtual desktop
# The --no-sandbox flag is required for Electron apps running inside Docker
RUN echo '#!/bin/sh\nexec grass --no-sandbox' > /startapp.sh \
    && chmod +x /startapp.sh