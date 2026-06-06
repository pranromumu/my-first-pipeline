import os
import logging
from fastapi import FastAPI
from pythonjsonlogger import jsonlogger

logger = logging.getLogger()
logHandler = logging.StreamHandler()
formatter = jsonlogger.JsonFormatter()
logHandler.setFormatter(formatter)
logger.addHandler(logHandler)
logger.setLevel(logging.INFO)

app = FastAPI()

GREETING_PREFIX = os.getenv("GREETING_PREFIX", "Hello")


@app.get("/health")
async def health_check():
    return {"status": "ok"}


@app.get("/hello/{name}")
async def hello(name: str):
    greeting = f"{GREETING_PREFIX} {name}"
    logger.info(
        f"Greeting generated: {greeting}",
        extra={
            "name": name,
            "greeting": greeting
        }
    )
    return {"message": greeting}


@app.get("/")
async def root():
    return {"status": "alive"}


@app.get("/routes")
async def show_routes():
    return [{"path": route.path, "name": route.name} for route in app.routes]