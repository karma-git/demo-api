from os import environ
from socket import gethostname
from datetime import datetime
from uuid import uuid4
from fastapi import FastAPI, status, Request
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
import uvicorn

app = FastAPI()

# Настройка Jinja2 templates
templates = Jinja2Templates(directory="templates")

# Подключение статических файлов
app.mount("/static", StaticFiles(directory="static"), name="static")


@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    """Главная страница с HTML интерфейсом"""
    data = {
        "language": "🐍 python",
        "hostname": gethostname(),
        "timestamp": datetime.now().isoformat(),
        "uuid": str(uuid4()),
    }
    
    headers = {
        "status": "HTTP/1.1 200 OK",
        "date": datetime.now().strftime("%a, %d %b %Y %H:%M:%S GMT"),
        "server": "uvicorn",
        "content_type": "text/html; charset=utf-8"
    }
    
    return templates.TemplateResponse("index.html", {
        "request": request,
        "data": data,
        "headers": headers
    })


@app.get("/api")
async def api_payload() -> dict:
    """API endpoint для получения JSON данных"""
    return {
        "language": "🐍 python",
        "hostname": gethostname(),
        "timestamp": datetime.now().isoformat(),
        "uuid": str(uuid4()),
    }


@app.get("/health", status_code=status.HTTP_200_OK)
async def health() -> dict:
    return {"status": "OK"}


if __name__ == "__main__":
    port = int(environ.get("PORT", 8080))
    uvicorn.run("main:app", reload=True, host="0.0.0.0", port=port, log_level="info")
