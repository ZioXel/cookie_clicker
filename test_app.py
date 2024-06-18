# test_app.py
from fastapi.testclient import TestClient
from app import app, state

client = TestClient(app)

def test_click():
    state.cookie_count = 0
    response = client.post("/click")
    assert response.status_code == 200
    assert response.json()["cookie_count"] == 1

def test_upgrade():
    state.cookie_count = 20
    state.upgrade_cost = 10
    response = client.post("/upgrade")
    assert response.status_code == 200
    assert response.json()["cookie_count"] == 10
    assert response.json()["click_value"] == 2
    assert response.json()["upgrade_cost"] == 20

def test_buy_basic_factory():
    state.cookie_count = 10
    response = client.post("/buy_basic_factory")
    assert response.status_code == 200
    assert response.json()["cookie_count"] == 0
    assert len(response.json()["factories"]) == 1
    assert response.json()["factories"][0]["production_rate"] == 1

def test_buy_advanced_factory():
    state.cookie_count = 20
    response = client.post("/buy_advanced_factory")
    assert response.status_code == 200
    assert response.json()["cookie_count"] == 0
    assert len(response.json()["factories"]) == 1
    assert response.json()["factories"][0]["production_rate"] == 2

def test_reset_game():
    state.cookie_count = 50
    response = client.post("/reset_game")
    assert response.status_code == 200
    assert response.json()["cookie_count"] == 0
    assert response.json()["click_value"] == 1
    assert response.json()["upgrade_cost"] == 10
    assert len(response.json()["factories"]) == 0
