# Port Conflict Detection Script for Windows
# Run this before deploying any new service

Write-Host "🔍 Checking for port conflicts..." -ForegroundColor Cyan

# Define reserved ports
$reservedPorts = @{
    "1000" = "n8n (primary)"
    "1001" = "n8n (backup)"
    "1002" = "pgAdmin"
    "1003" = "PostgreSQL"
    "1004" = "RPL Frontend"
    "1005" = "Cloudflare Tunnel"
    "2000" = "Stella App"
    "3000" = "n8n dev"
    "3001" = "pgAdmin dev"
    "3002" = "Test frontend"
    "4000" = "Prometheus"
    "4001" = "Grafana"
    "4002" = "Portainer"
}

# Check for conflicts
$conflicts = 0

Write-Host "📋 Reserved Ports:" -ForegroundColor Yellow
foreach ($port in $reservedPorts.Keys) {
    $isInUse = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($isInUse) {
        Write-Host "  ❌ Port $port is in use: $($reservedPorts[$port])" -ForegroundColor Red
        $conflicts++
    } else {
        Write-Host "  ✅ Port $port is free: $($reservedPorts[$port])" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "🔍 All Active Ports:" -ForegroundColor Yellow
Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"} | Sort-Object LocalPort | Format-Table LocalAddress, LocalPort, State -AutoSize

Write-Host ""
if ($conflicts -eq 0) {
    Write-Host "✅ No port conflicts detected!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ $conflicts port conflict(s) detected!" -ForegroundColor Red
    Write-Host "Please resolve conflicts before deploying new services." -ForegroundColor Red
    exit 1
}
