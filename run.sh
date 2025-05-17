#/usr/bin/bash
uv sync
uv run ruff check .
uv run uvicorn main:app --reload
