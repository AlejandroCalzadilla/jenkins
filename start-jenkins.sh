#!/bin/bash

echo "=== Laboratorio Jenkins con Docker ==="
echo "Iniciando Jenkins..."

# Construir e iniciar Jenkins
docker-compose up -d

echo "Esperando que Jenkins inicie (esto puede tomar unos minutos)..."
sleep 30

echo "Jenkins está iniciando en http://localhost:8080"
echo ""
echo "Para obtener la contraseña inicial, ejecuta:"
echo "docker exec jenkins-lab cat /var/jenkins_home/secrets/initialAdminPassword"
echo ""
echo "Comandos útiles:"
echo "- Ver logs: docker-compose logs -f jenkins"
echo "- Detener: docker-compose down"
echo "- Reiniciar: docker-compose restart"
