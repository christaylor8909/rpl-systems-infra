# RPL Systems Deployment Checklist

## Before Deploying Any New Service

### 1. Port Conflict Check
```bash
# On Linux/Mac
./scripts/check-ports.sh

# On Windows
powershell -ExecutionPolicy Bypass -File scripts/check-ports.ps1
```

### 2. Resource Check
```bash
# Check available memory
free -h

# Check disk space
df -h

# Check CPU usage
top
```

### 3. Service Dependencies
- [ ] PostgreSQL is running
- [ ] Cloudflare tunnel is configured
- [ ] Environment variables are set
- [ ] No port conflicts detected

## Current Port Allocations

| Service | Port | Purpose | Status |
|---------|------|---------|--------|
| n8n | 1000 | Primary automation | ✅ Reserved |
| pgAdmin | 1002 | Database admin | ✅ Reserved |
| PostgreSQL | 1003 | Database (internal) | ✅ Reserved |
| RPL Frontend | 1004 | Web interface | ✅ Reserved |
| Cloudflare Tunnel | 1005 | Public access | ✅ Reserved |
| Stella App | 2000 | Business app | ✅ In Use |

## Emergency Procedures

### If Port Conflicts Occur:
1. Stop conflicting service: `docker stop <container-name>`
2. Check port allocation: `netstat -tulpn | grep <port>`
3. Reassign to backup port in same range
4. Update documentation

### If Services Won't Start:
1. Check logs: `docker-compose logs <service>`
2. Check resources: `docker stats`
3. Check dependencies: `docker-compose ps`
4. Restart in order: postgres → n8n → pgadmin → frontend → cloudflared

## Deployment Commands

```bash
# Full deployment
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Restart specific service
docker-compose restart <service-name>
```
