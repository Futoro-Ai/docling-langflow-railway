# Docling + LangFlow Railway Deployment

This repository contains the configuration and code for deploying **LangFlow** with **Docling** support to [Railway.app](https://railway.app).

## Overview

The project is containerized using Docker and is designed to be easily deployed to Railway. It includes:
- `Dockerfile`: Defines the runtime environment with Python 3.10, LangFlow, and Docling.
- `requirements.txt`: Python dependencies.
- `test_docling.py`: A smoke test script to verify Docling functionality.
- `app/`: Directory for application code.

## Deployment

For detailed deployment instructions, please refer to:
- [README_DOCKER.md](README_DOCKER.md): For local Docker build and run instructions.
- [railway_deploy.md](railway_deploy.md): For Railway-specific deployment steps.

## Local Development

1. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Run LangFlow**:
   ```bash
   python -m langflow run
   ```

3. **Test Docling**:
   ```bash
   python test_docling.py
   ```
