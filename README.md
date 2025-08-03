# Laboratorio Jenkins con Docker

Este proyecto contiene un ejemplo de integración continua usando Jenkins con Docker para un proyecto Spring Boot.

## Requisitos Previos

- Docker Desktop instalado y ejecutándose
- Git instalado
- Puerto 8080 disponible

## Instalación y Configuración

### Paso 1: Iniciar Jenkins

1. **Asegúrate de que Docker Desktop esté ejecutándose**

2. **Ejecuta el script de inicio:**
   ```powershell
   .\start-jenkins.ps1
   ```
   
   O manualmente:
   ```powershell
   docker-compose up -d
   ```

3. **Espera a que Jenkins inicie** (puede tomar 2-3 minutos)

### Paso 2: Acceder a Jenkins

1. Abre tu navegador y ve a: http://localhost:8080

2. **Obten la contraseña inicial:**
   ```powershell
   docker exec jenkins-lab cat /var/jenkins_home/secrets/initialAdminPassword
   ```

3. Copia la contraseña que aparece en la terminal

### Paso 3: Configuración Inicial de Jenkins

1. Pega la contraseña inicial en Jenkins
2. Selecciona "Install suggested plugins"
3. Crea un usuario administrador
4. Mantén la URL por defecto (http://localhost:8080)

### Paso 4: Configurar Herramientas Globales

1. Ve a **Manage Jenkins** → **Global Tool Configuration**

2. **Configurar JDK:**
   - Nombre: `JDK17`
   - JAVA_HOME: `/opt/java/openjdk` (ya incluido en el contenedor)

3. **Configurar Maven:**
   - Nombre: `Maven`
   - MAVEN_HOME: `/usr/share/maven` (ya incluido en el contenedor)

### Paso 5: Crear un Freestyle Project

1. En el dashboard, haz clic en **"New Item"**
2. Nombre: `spring-boot-demo`
3. Selecciona **"Freestyle project"**
4. Haz clic en **"OK"**

#### Configuración del Proyecto:

**Source Code Management:**
- Selecciona **Git**
- Repository URL: (la URL de tu repositorio Git)
- Credentials: (configura si es necesario)

**Build Environment:**
- ☑️ Delete workspace before build starts

**Build Steps:**
- Añadir build step → **"Invoke top-level Maven targets"**
- Goals: `clean compile test package`

**Post-build Actions:**
- Añadir → **"Archive the artifacts"**
- Files to archive: `target/*.jar`
- Añadir → **"Publish JUnit test result report"**
- Test report XMLs: `target/surefire-reports/*.xml`

### Paso 6: Ejecutar el Job

1. En la página del proyecto, haz clic en **"Build Now"**
2. Ve a la **Console Output** para ver el progreso
3. Verifica que el build sea exitoso

## Estructura del Proyecto

```
jenkins/
├── docker-compose.yml    # Configuración de Docker Compose
├── Dockerfile           # Imagen personalizada de Jenkins
├── Jenkinsfile         # Pipeline como código
├── start-jenkins.ps1   # Script de inicio para Windows
├── start-jenkins.sh    # Script de inicio para Linux/Mac
├── pom.xml            # Configuración Maven del proyecto Spring Boot
└── src/               # Código fuente del proyecto Spring Boot
```

## Comandos Útiles

```powershell
# Ver logs de Jenkins
docker-compose logs -f jenkins

# Detener Jenkins
docker-compose down

# Reiniciar Jenkins
docker-compose restart

# Acceder al contenedor
docker exec -it jenkins-lab bash

# Ver contraseña inicial
docker exec jenkins-lab cat /var/jenkins_home/secrets/initialAdminPassword
```

## Pipeline como Código (Opcional)

Para usar el Jenkinsfile incluido:

1. Crea un nuevo **Pipeline project**
2. En **Pipeline** → **Definition**, selecciona **"Pipeline script from SCM"**
3. Configura tu repositorio Git
4. Script Path: `Jenkinsfile`

## Troubleshooting

### Error: Puerto 8080 ocupado
```powershell
# Cambiar puerto en docker-compose.yml
ports:
  - "8081:8080"  # Usar puerto 8081 en lugar de 8080
```

### Error: Docker no disponible
- Asegúrate de que Docker Desktop esté ejecutándose
- Verifica que tengas permisos de administrador

### Error: Maven no encontrado
- El Dockerfile ya incluye Maven
- Verifica la configuración en Global Tool Configuration

## Capturas Requeridas

1. Dashboard de Jenkins mostrando el proyecto creado
2. Console output de un build exitoso
3. Artifacts generados (archivo JAR)
4. Resultados de las pruebas

## Enlaces Útiles

- [Documentación oficial de Jenkins](https://www.jenkins.io/doc/)
- [Spring Boot con Jenkins](https://spring.io/guides/gs/jenkins/)
- [Docker Compose para Jenkins](https://github.com/jenkinsci/docker)
