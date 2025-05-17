@echo off
REM Run FastAPI server with uvicorn
uv run uvicorn main:app --reload
