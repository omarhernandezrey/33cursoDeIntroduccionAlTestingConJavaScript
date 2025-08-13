#!/bin/bash
echo "🧪 Probando Docker..."
docker run --rm hello-world
echo ""
echo "🧪 Probando Docker Compose..."
docker compose version
echo ""
echo "🧪 Probando conexión a Docker daemon..."
docker ps