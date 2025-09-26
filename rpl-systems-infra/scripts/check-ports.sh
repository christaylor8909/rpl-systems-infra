#!/bin/bash

# Port Conflict Detection Script
# Run this before deploying any new service

echo "🔍 Checking for port conflicts..."

# Define reserved ports
declare -A RESERVED_PORTS=(
    ["1000"]="n8n (primary)"
    ["1001"]="n8n (backup)"
    ["1002"]="pgAdmin"
    ["1003"]="PostgreSQL"
    ["1004"]="RPL Frontend"
    ["1005"]="Cloudflare Tunnel"
    ["2000"]="Stella App"
    ["3000"]="n8n dev"
    ["3001"]="pgAdmin dev"
    ["3002"]="Test frontend"
    ["4000"]="Prometheus"
    ["4001"]="Grafana"
    ["4002"]="Portainer"
)

# Check for conflicts
CONFLICTS=0

echo "📋 Reserved Ports:"
for port in "${!RESERVED_PORTS[@]}"; do
    if netstat -tuln | grep -q ":$port "; then
        echo "  ❌ Port $port is in use: ${RESERVED_PORTS[$port]}"
        CONFLICTS=$((CONFLICTS + 1))
    else
        echo "  ✅ Port $port is free: ${RESERVED_PORTS[$port]}"
    fi
done

echo ""
echo "🔍 All Active Ports:"
netstat -tuln | grep LISTEN | sort -k4 -n

echo ""
if [ $CONFLICTS -eq 0 ]; then
    echo "✅ No port conflicts detected!"
    exit 0
else
    echo "❌ $CONFLICTS port conflict(s) detected!"
    echo "Please resolve conflicts before deploying new services."
    exit 1
fi
