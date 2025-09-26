from fastapi import APIRouter

#Create a router for health check
router = APIRouter()

endpoint = 'http://127.0.0.1:8000/health'

@router.get("/health", status_code=200)
async def health_check():
    """
    Vérifie si l'API fonctionne correctement.
    """
    return {"status": "healthy"}