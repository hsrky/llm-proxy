from fastapi import FastAPI, Request, APIRouter
from fastapi.responses import StreamingResponse
import httpx
import asyncio
import os

XAI_API_KEY = os.environ["XAI_API_KEY"]
XAI_API_URL = "https://api.x.ai/v1"
TIMEOUT = 120.0

app = FastAPI()
xai = APIRouter(prefix="/xai")
client = httpx.AsyncClient(timeout=httpx.Timeout(30, read=TIMEOUT))


@app.get("/sse")
async def stream(request: Request):
    # This is a simple example of a server-sent events (SSE) endpoint.
    async def event_generator():
        while True:
            yield f"data: {os.urandom(16).hex()}\n"
            await asyncio.sleep(1)

    return StreamingResponse(event_generator(), media_type="text/event-stream")


async def forward_request(path: str, request: Request):
    """Generic request forwarding with streaming support."""
    url = f"{XAI_API_URL}/{path.lstrip('/')}"

    # Prepare headers (filter out FastAPI-specific headers)
    forward_headers = {
        k: v
        for k, v in request.headers.items()
        if k.lower() not in {"host", "content-length"}
    }

    body = await request.body()

    async def generate():
        async with client.stream(
            request.method, url, headers=forward_headers, content=body
        ) as response:
            response.raise_for_status()
            async for chunk in response.aiter_bytes():
                yield chunk

    return StreamingResponse(generate(), media_type="application/json")


@xai.post("/chat/completions")
async def chat_completions(request: Request):
    return await forward_request("/chat/completions", request)


@xai.post("/completions")
async def completions(request: Request):
    return await forward_request("/completions", request)


@xai.post("/embeddings")
async def embeddings(request: Request):
    return await forward_request("/embeddings", request)


@xai.get("/models")
async def models(request: Request):
    """
    Get the list of models from the XAPI API.
    """
    response = await client.get(
        XAI_API_URL + "/models", headers={"Authorization": f"Bearer {XAI_API_KEY}"}
    )

    # Return the response from the XAPI API
    return response.json()


@xai.get("/models/{model_id}")
async def model(request: Request, model_id: str):
    """
    Get the details of a specific model from the XAPI API.
    """
    response = await client.get(
        XAI_API_URL + f"/models/{model_id}",
        headers={"Authorization": f"Bearer {XAI_API_KEY}"},
    )

    # Return the response from the XAPI API
    return response.json()


app.include_router(xai)
