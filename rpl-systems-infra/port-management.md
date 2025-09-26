# RPL Systems Port Management

## Reserved Port Ranges

### Core Infrastructure (1000-1999)
- **1000-1099**: RPL Systems Core Services
  - 1000: n8n (primary)
  - 1001: n8n (backup/development)
  - 1002: pgAdmin
  - 1003: PostgreSQL (internal)
  - 1004: RPL Frontend
  - 1005: Cloudflare Tunnel (internal)

### Application Services (2000-2999)
- **2000-2099**: Business Applications
  - 2000: Stella App (current)
  - 2001-2009: Reserved for future business apps

### Development/Testing (3000-3999)
- **3000-3099**: Development environments
  - 3000: n8n dev
  - 3001: pgAdmin dev
  - 3002: Test frontend

### Monitoring/Admin (4000-4999)
- **4000-4099**: Monitoring tools
  - 4000: Prometheus
  - 4001: Grafana
  - 4002: Portainer

## Port Conflict Prevention

### Before Deploying New Services:
1. Check this document for reserved ports
2. Run port conflict detection script
3. Update this document with new allocations
4. Test in development environment first

### Emergency Port Reassignment:
If conflicts occur, use the backup ports in the same range.
