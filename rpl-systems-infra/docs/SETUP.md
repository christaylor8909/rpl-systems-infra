# rpl-systems-infra quick start

1) Copy env template and fill secrets:
   cp .env.example .env
   # edit .env and set:
   # - POSTGRES_PASSWORD
   # - N8N_ENCRYPTION_KEY (long random)
   # - N8N_BASIC_AUTH_PASSWORD

2) Bring the stack up:
   docker compose up -d

3) Access:
   - n8n:          http://localhost:5678
   - RPL frontend: http://localhost:8080

Replace ./rpl-frontend/public with your built frontend (or switch the service to your own Docker image).
