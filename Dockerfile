FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=8080
ENV LANGFLOW_HOST=0.0.0.0

# Install system dependencies required for Docling and general build tools
# libgl1 and libglib2.0-0 are often needed for vision/PDF libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Install uv for faster pip installs
RUN pip install uv

# Copy requirements and install dependencies
COPY requirements.txt .
# Use uv to install dependencies (much faster than pip)
# --system installs into the system python environment
RUN uv pip install --system --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the port
EXPOSE $PORT

# Healthcheck to ensure the service is running
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:$PORT/health || exit 1

# Command to run LangFlow
CMD ["sh", "-c", "python -m langflow run --host $LANGFLOW_HOST --port $PORT"]
