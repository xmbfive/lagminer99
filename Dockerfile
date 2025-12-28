# Use Ubuntu as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev && \
    rm -rf /var/lib/apt/lists/*

# Clone XMRig repository
RUN git clone https://github.com/xmrig/xmrig.git /xmrig

# Build XMRig
WORKDIR /xmrig
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Copy config file
COPY xmrig-config.json /xmrig/build/config.json

# Set working directory
WORKDIR /xmrig/build

# Start XMRig miner
CMD ["./xmrig", "-c", "config.json"]
