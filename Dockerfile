# Use an official Python runtime environment
FROM python:3.11-slim

# Install Stockfish directly via the system package manager
RUN apt-get update && apt-get install -y \
    stockfish \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory inside the container
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the internal port Render needs for the fake health check server
EXPOSE 8080

# Start the application
CMD ["python", "main.py"]
