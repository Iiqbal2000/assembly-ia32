# Use the specified image as the base
FROM debian:stable-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libc6-i386 \
    && rm -rf /var/lib/apt/lists/*  # Cleanup to reduce image size

# Download and extract the fasm package
WORKDIR /usr/local/src
RUN wget https://flatassembler.net/fasm-1.73.31.tgz \
    && tar -xvzf fasm-1.73.31.tgz \
    && rm fasm-1.73.31.tgz  # Cleanup to reduce image size

# Move the fasm binary to a location in the system PATH
RUN mv fasm/fasm /usr/local/bin

# Set the working directory back to the default, if needed
WORKDIR /