# Use Node LTS on Debian slim as base image
FROM node:lts-bookworm-slim

# Install necessary tools and Python
RUN apt-get update && apt-get install -y \
  git \
  curl \
  ca-certificates \
  nano \
  vim-tiny \
  python3 \
  python3-pip \
  python3-venv \
  && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI using native installer
RUN curl -fsSL https://claude.ai/install.sh | bash

# Add Claude to PATH
ENV PATH="/root/.local/bin:${PATH}"

# Copy Claude Code configuration (settings, skills)
COPY config/settings.json /root/.claude/settings.json
COPY config/skills/ /root/.claude/skills/

# Set working directory
WORKDIR /workspace

CMD ["/bin/bash"]
