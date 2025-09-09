#!/bin/bash

# RPL Systems AWS Lightsail Deployment Script
# Run this script on your Lightsail instance after initial setup

set -e  # Exit on any error

echo " Starting RPL Systems deployment..."

# Check if running as root
if [ "" -eq 0 ]; then
    echo " Please don't run this script as root. Use: sudo -u ubuntu ./deploy.sh"
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo " Docker is not installed. Please run the server setup first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo " Docker Compose is not installed. Please run the server setup first."
    exit 1
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo " .env file not found. Please copy .env.production to .env and configure it."
    exit 1
fi

# Check if required environment variables are set
if grep -q "CHANGE_THIS" .env; then
    echo " Please update your .env file with actual values (remove all 'CHANGE_THIS' placeholders)."
    exit 1
fi

echo " Prerequisites check passed"

# Pull latest changes
echo " Pulling latest changes from repository..."
git pull origin main

# Pull latest Docker images
echo " Pulling latest Docker images..."
docker-compose pull

# Start services
echo " Starting services..."
docker-compose up -d

# Wait for services to be healthy
echo " Waiting for services to be healthy..."
sleep 10

# Check service status
echo " Service status:"
docker-compose ps

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo " Deployment successful!"
    echo ""
    echo " Your services are now running:"
    echo "   - N8N: Check your Cloudflare tunnel or domain"
    echo "   - Frontend: Check your Cloudflare tunnel or domain/app"
    echo "   - PostgreSQL: Running internally"
    echo ""
    echo " Useful commands:"
    echo "   - View logs: docker-compose logs -f"
    echo "   - Restart: docker-compose restart"
    echo "   - Stop: docker-compose down"
    echo "   - Update: ./deploy.sh"
else
    echo " Some services failed to start. Check logs with: docker-compose logs"
    exit 1
fi
