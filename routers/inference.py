from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

#Create a router for inference
router = APIRouter()

endpoint = 'http://127.0.0.1:8000/inference'

class Inference(BaseModel):
    input_data: str

@router.post("/inference", status_code=200)
async def process_inference(request: Inference):
    """
    Accepts a POST request to perform inference on the data provided by the client.
    """
    try:
        # Example of a virtual result
        result = {
            "input": request.input_data,
            "output": f"Inferred: {request.input_data}"
        }
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur : {e}")