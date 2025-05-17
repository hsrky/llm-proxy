# Use official Python image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# create a self-signed certificate to prevent sniffing
RUN openssl req -x509 -newkey rsa:4096 -days 365 -nodes -subj "/CN=localhost" \
    -rand /dev/urandom \
    -keyout key.pem -out cert.pem

RUN pip install --no-cache-dir uv

COPY . .

RUN if [ -f pyproject.toml ]; then uv sync; fi

# Expose FastAPI default port
EXPOSE 8443

# Run FastAPI app with uvicorn
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8443", \
    "--ssl-keyfile=key.pem", "--ssl-certfile=cert.pem"]
