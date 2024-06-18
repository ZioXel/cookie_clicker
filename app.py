from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import asyncio
from typing import List, Dict

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Factory(BaseModel):
    cost: int
    production_rate: int

    def produce(self):
        return self.production_rate

class BasicFactory(Factory):
    cost: int = 10
    production_rate: int = 1

class AdvancedFactory(Factory):
    cost: int = 20
    production_rate: int = 2

class State(BaseModel):
    cookie_count: int = 0
    click_value: int = 1
    upgrade_cost: int = 10
    factories: List[Dict[str, int]] = Field(default_factory=list)

state = State()

@app.post("/buy_basic_factory")
def buy_basic_factory():
    factory = BasicFactory()
    if state.cookie_count >= factory.cost:
        state.cookie_count -= factory.cost
        state.factories.append(factory.dict())
    return state

@app.post("/buy_advanced_factory")
def buy_advanced_factory():
    factory = AdvancedFactory()
    if state.cookie_count >= factory.cost:
        state.cookie_count -= factory.cost
        state.factories.append(factory.dict())
    return state

@app.post("/click")
def click():
    state.cookie_count += state.click_value
    return state

@app.post("/upgrade")
def upgrade():
    if state.cookie_count >= state.upgrade_cost:
        state.cookie_count -= state.upgrade_cost
        state.click_value += 1
        state.upgrade_cost *= 2
    return state

@app.post("/reset_game")
def reset_game():
    global state
    state = State()
    return state

async def produce_cookies():
    while True:
        for factory in state.factories:
            state.cookie_count += factory['production_rate']
        await asyncio.sleep(1)  # Czekaj 1 sekunde na update

@app.on_event("startup")
async def startup_event():
    print("Starting up")
    asyncio.create_task(produce_cookies())

@app.on_event("shutdown")
async def shutdown_event():
    print("Shutting down")

@app.get("/state")
def get_state():
    return state

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
