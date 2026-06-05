from fastapi import FastAPI
from src.utils import format_greeting

app = FastAPI()


@app.get("/hello/{name}")
async def hello(name: str):
    greeting = format_greeting(name)
    return {"message": greeting}
