# Dockerfile pour Serveur MCP 
FROM docker.registry.vptech.eu/python:3.11-slim

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set non-root user and add group/user if they don't already exist
RUN addgroup --gid 10001 appuser && \
    adduser --disabled-password --gecos '' --uid 100001 --gid 10001 appuser

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy requirements.txt first (for better caching)
COPY requirements.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY main.py ./
COPY app/ ./app/
COPY routers/ ./routers/
COPY starfish/ ./starfish/

# Change ownership of all files to appuser
RUN chown -R 100001:10001 /usr/src/app

# Switch to non-root user
USER appuser

# Set environment to production
ENV NODE_ENV=production
ENV PORT=8000
ENV HOSTNAME="0.0.0.0"

# The application's port
EXPOSE 8000

# Health check for the container
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Run the FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
