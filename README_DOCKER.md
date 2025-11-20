# Docker Build & Run Instructions

## Prerequisites
- Docker installed on your machine.

## Build the Image

Run the following command in the root of the repository:

```bash
docker build -t docling-langflow .
```

## Run the Container

Run the container exposing port 7860 (or whichever port LangFlow uses, default is often 7860, but we mapped PORT env var):

```bash
docker run -p 7860:7860 -e PORT=7860 docling-langflow
```

*Note: The Dockerfile uses the `PORT` environment variable to determine which port LangFlow listens on.*

## Verify the Build

1. Open your browser and go to `http://localhost:7860`.
2. You should see the LangFlow UI.

## Run Smoke Test inside Docker

To verify that Docling is working correctly inside the container:

```bash
docker run --rm docling-langflow python test_docling.py
```
