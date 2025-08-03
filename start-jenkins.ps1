# Script para iniciar Jenkins en Windows
Write-Host "=== Laboratorio Jenkins con Docker ===" -ForegroundColor Green
Write-Host "Iniciando Jenkins..." -ForegroundColor Yellow

# Construir e iniciar Jenkins
docker-compose up -d

Write-Host "Esperando que Jenkins inicie (esto puede tomar unos minutos)..." -ForegroundColor Yellow
Start-Sleep 30

Write-Host ""
Write-Host "Jenkins está iniciando en http://localhost:8080" -ForegroundColor Green
Write-Host ""
Write-Host "Para obtener la contraseña inicial, ejecuta:" -ForegroundColor Cyan
Write-Host "docker exec jenkins-lab cat /var/jenkins_home/secrets/initialAdminPassword" -ForegroundColor White
Write-Host ""
Write-Host "Comandos útiles:" -ForegroundColor Cyan
Write-Host "- Ver logs: docker-compose logs -f jenkins" -ForegroundColor White
Write-Host "- Detener: docker-compose down" -ForegroundColor White
Write-Host "- Reiniciar: docker-compose restart" -ForegroundColor White
