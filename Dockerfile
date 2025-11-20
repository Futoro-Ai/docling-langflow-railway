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

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose the port
EXPOSE $PORT

# Command to run LangFlow
# Using python -m langflow run is a common way, but let's check if we need a specific entry point.
# The PRD mentions "LangFlow UI loads".
CMD ["sh", "-c", "python -m langflow run --host $LANGFLOW_HOST --port $PORT"]
