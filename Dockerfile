# Use Python base image
FROM python:3.11-slim

# Set environment variable for path
ENV PATH="/opt/venv/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Create a virtual environment and install dependencies
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Start the app
CMD ["gunicorn", "home_decor_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
