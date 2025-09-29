# Test script for MCP API
Write-Host "Testing MCP API..." -ForegroundColor Green

# Test root endpoint
Write-Host "`n1. Testing root endpoint (/):" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/" -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test health endpoint
Write-Host "`n2. Testing health endpoint (/health):" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/health" -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test inference POST endpoint
Write-Host "`n3. Testing inference POST endpoint (/inference):" -ForegroundColor Yellow
try {
    $body = @{
        input_data = "test data"
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/inference" -Method POST -Body $body -ContentType "application/json" -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test inference PUT endpoint
Write-Host "`n4. Testing inference PUT endpoint (/inference/123):" -ForegroundColor Yellow
try {
    $body = @{
        input_data = "updated test data"
    } | ConvertTo-Json
    
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/inference/123" -Method PUT -Body $body -ContentType "application/json" -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test inference DELETE endpoint
Write-Host "`n5. Testing inference DELETE endpoint (/inference/123):" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:8000/inference/123" -Method DELETE -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Response: $($response.Content)" -ForegroundColor Cyan
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

Write-Host "`nTesting completed!" -ForegroundColor Green