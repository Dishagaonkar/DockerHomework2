# FROM python:3.11-alpine
# WORKDIR /app
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# RUN apk add --no-cache gcc musl-dev
# COPY app/requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# EXPOSE 5000
# COPY . .
# CMD ["flask", "run", "--debug", "python", "app.py"]



# docker/Dockerfile.app
# FROM python:3.11-alpine

# # Install build tools for dependencies
# RUN apk add --no-cache gcc musl-dev

# # Working directory inside the container
# WORKDIR /app

# # Copy and install requirements
# COPY src/requirements.txt ./requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the entire project into the container
# COPY . .

# # Make src importable as a top-level module
# ENV PYTHONPATH=/app

# # Tell Flask where to find the app instance
# ENV FLASK_APP=src.app:app
# ENV FLASK_RUN_HOST=0.0.0.0
# ENV FLASK_RUN_PORT=5000

# EXPOSE 5000

# # Start Flask using the CLI
# CMD ["flask", "run"]


# Use a lightweight Python base
FROM python:3.11-alpine

# Install system dependencies required for compiling Python packages
RUN apk add --no-cache gcc musl-dev

# Set working directory
WORKDIR /app

# Copy and install dependencies
COPY src/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install gunicorn==22.0.0

# Copy the application code
COPY . .

# Ensure Python can import from /app/src
ENV PYTHONPATH=/app

# Expose the Flask app port
EXPOSE 5000

# Start the app using Gunicorn (not flask run)
CMD ["gunicorn", "--chdir", "src", "--bind", "0.0.0.0:5000", "app:app"]

