"""
Fast API application
ref: https://fastapi.tiangolo.com/
"""
from os import environ
from socket import gethostname
from datetime import datetime
from uuid import uuid4
from fastapi import FastAPI, status
import uvicorn

app = FastAPI()


@app.get("/")
async def main_payload() -> dict:
    """Check container"""
    return {"language": "python","hostname": gethostname(), "timestamp": datetime.now(), "uuid": uuid4()}


@app.get("/health", status_code=status.HTTP_200_OK)
async def check_health() -> dict:
    """Smoke test ep"""
    return {"status": "OK"}

if __name__ == "__main__":
    port = int(environ.get("PORT", 8080))
    uvicorn.run("main:app", reload=True, host="0.0.0.0", port=port, log_level="info")
