from fastapi import FastAPI
from app.routers import health, inference

# Create the app 
app = FastAPI()

# Include health and inference routers in the main app
app.include_router(health.router)
#app.include_router(inference.router)

@app.get("/")
def root():
    return {"message": "Welcome to the API dedicated to the MCP server !"}