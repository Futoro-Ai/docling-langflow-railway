# Railway Deployment Guide

This guide explains how to deploy the Docling + LangFlow application to Railway.app.

## Prerequisites
- A GitHub account with this repository pushed.
- A [Railway.app](https://railway.app) account.

## Steps

1. **New Project**:
   - Go to your Railway dashboard.
   - Click "New Project" -> "Deploy from GitHub repo".
   - Select this repository (`docling-langflow-railway`).

2. **Configure Variables**:
   - Before the first deployment (or in the "Variables" tab after), add the following environment variables:
     - `PORT`: Railway usually sets this automatically, but ensure your application respects it. (The Dockerfile is configured to use `$PORT`).
     - `LANGFLOW_WORKERS`: `1` (Recommended to reduce memory usage).
     - `HF_HOME`: `/app/data/cache` (Optional: if you want to persist HuggingFace models, see Volumes below).

3. **Volumes (Optional but Recommended)**:
   - To persist data (like uploaded files or model cache) across deployments, add a Volume in Railway.
   - Mount path: `/app/data` (or wherever you want to store persistent data).
   - Update `HF_HOME` to point to a subdirectory in the volume, e.g., `/app/data/cache`.

4. **Deploy**:
   - Railway will automatically build the Docker image from the `Dockerfile`.
   - Watch the "Deployments" tab for logs.

5. **Verify**:
   - Once deployed, Railway will provide a public URL (e.g., `https://web-production-xxxx.up.railway.app`).
   - Visit the URL to access LangFlow.

## Troubleshooting

- **Build Failures**: Check the "Build Logs". Ensure all system dependencies (like `libgl1`) are in the `Dockerfile`.
- **Runtime Errors**: Check "Deploy Logs".
- **Docling Issues**: You can run the smoke test in the Railway console (if available) or add a wrapper script to run it on startup.
