FROM jenkins/jenkins:lts

# Cambiar a usuario root para instalar paquetes
USER root

# Instalar Maven, Git y otras herramientas necesarias
RUN apt-get update && \
    apt-get install -y maven git curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Volver al usuario jenkins
USER jenkins

# Instalar plugins básicos
RUN jenkins-plugin-cli --plugins \
    git \
    maven-integration \
    workflow-aggregator \
    pipeline-stage-view \
    build-timeout \
    credentials-binding \
    timestamper \
    ws-cleanup
