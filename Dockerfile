# Use official Python image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

RUN pip install --no-cache-dir uv

COPY . .

RUN if [ -f pyproject.toml ]; then uv sync; fi

# Expose FastAPI default port
EXPOSE 8000

# Run FastAPI app with uvicorn
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
