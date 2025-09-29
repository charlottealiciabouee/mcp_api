# main.py
from fastapi import FastAPI, APIRouter, HTTPException
from pydantic import BaseModel

app = FastAPI(title="MCP Server API")

@app.get("/")
def root():
    return {"message": " Hello !"}

#health check endpoint
health_router = APIRouter()

@health_router.get("/health", status_code=200)
async def health_check():
    """
    Vérifie si l'API fonctionne correctement.
    """
    return {"status": "healthy"}

health_endpoint = 'http://127.0.0.1:8000/health'

# Inference endpoint
inference_router = APIRouter()

class Inference(BaseModel):
    input_data: str

@inference_router.post("/inference", status_code=201)
async def process_inference(request: Inference):
    try:
        return {
            "input": request.input_data,
            "output": f"Inferred: {request.input_data}"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur : {e}")

@inference_router.put("/inference/{item_id}", status_code=200)
async def update_inference(item_id: int, data: Inference):
    return {
        "item_id": item_id,
        "updated_data": data.input_data,
        "message": "Item successfully updated!"
    }

@inference_router.delete("/inference/{item_id}", status_code=200)
async def delete_inference(item_id: int):
    return {"message": f"Item {item_id} successfully deleted."}

inference_endpoint = 'http://127.0.0.1:8000/inference'

app.include_router(health_router)
app.include_router(inference_router)

# Run the application
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
