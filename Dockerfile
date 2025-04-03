# Use a imagem base do Tomcat 7 com Java
FROM tomcat:7-jdk8

# Configurar variáveis de ambiente
ENV CATALINA_OPTS="-Xmx512m"
ENV JAVA_OPTS="-Xmx512m"

# Instalar curl para healthcheck
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Copiar o arquivo WAR da aplicação
COPY tomcat/webapps/ROOT/ /usr/local/tomcat/webapps/ROOT/

# Copiar as configurações do Tomcat
COPY tomcat/conf/ /usr/local/tomcat/conf/

# Copiar as bibliotecas necessárias
COPY tomcat/lib/ /usr/local/tomcat/lib/

# Criar diretório para dados persistentes
RUN mkdir -p /usr/local/tomcat/data && \
    chmod 777 /usr/local/tomcat/data

# Criar script de inicialização
RUN echo '#!/bin/bash\ntrap "" TERM INT\ncatalina.sh run' > /usr/local/tomcat/bin/start.sh && \
    chmod +x /usr/local/tomcat/bin/start.sh

# Expor a porta 8080
EXPOSE 8080

# Configurar healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/health.jsp || exit 1

# Comando para iniciar o Tomcat em primeiro plano
CMD ["/usr/local/tomcat/bin/start.sh"]
