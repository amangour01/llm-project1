# Use Python 3.9 slim base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies including Tesseract OCR
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    nodejs \
    npm \
    git \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .
COPY LICENSE .

# Create data directory
# RUN mkdir -p C:/data

# Set environment variables
# ENV DATA_DIR=/data
ENV PYTHONUNBUFFERED=1

# Expose port
EXPOSE 8001

# Command to run the application
CMD ["uvicorn", "app:app", "--host", "127.0.0.1", "--port", "8001"]