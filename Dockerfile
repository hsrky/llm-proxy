# Use official Python image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# create a self-signed certificate to enable https/prevent sniffing
RUN mkdir /cert/ && openssl req -x509 -newkey rsa:4096 -days 365 -nodes -subj "/CN=localhost" \
    -rand /dev/urandom \
    -keyout /cert/privkey1.pem -out /cert/fullchain1.pem

RUN pip install --no-cache-dir uv

COPY . .

RUN useradd -m appuser && chown -R appuser /app
USER appuser

RUN if [ -f pyproject.toml ]; then uv sync; fi

# Expose FastAPI default port
EXPOSE 8443

# Run FastAPI app with uvicorn
CMD ["uv", "run", "uvicorn", "main:app", \
    "--host", "0.0.0.0", \
    "--port", "8443", \
    "--ssl-keyfile", "/cert/privkey1.pem", \
    "--ssl-certfile", "/cert/fullchain1.pem"]


