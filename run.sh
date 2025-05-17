#!/usr/bin/env bash
uv sync
uv run ruff check .
uv run uvicorn main:app --reload
