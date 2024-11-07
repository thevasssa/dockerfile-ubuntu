# Ubuntu Development Container

This repository contains a Dockerfile and setup script for a development container with essential tools and environments.

## Prerequisites

- Docker or Podman installed on your system.

## Dockerfile Overview

The Dockerfile builds a development container on top of the latest Ubuntu image, adding:
- Development tools and utilities (e.g., `curl`, `git`, `vim`, `tmux`).
- Node.js and npm, Python 3 and pip, OpenJDK 21, Go, and Rust.
- Database clients: PostgreSQL Client and Redis CLI.
- Zsh with Oh My Zsh, with themes and plugins for an enhanced shell experience.

## Usage Instructions

1. Clone this repository to your local machine.
2. Build and start the container using the provided script.
3. (Optional) Modify the Docikerfile to suit your specific requirements.

