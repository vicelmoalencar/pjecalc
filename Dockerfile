# Use a imagem base do Tomcat 7 com Java
FROM tomcat:7-jdk8

# Configurar variáveis de ambiente
ENV CATALINA_OPTS="-Xmx512m"
ENV JAVA_OPTS="-Xmx512m"

# Copiar o arquivo WAR da aplicação
COPY tomcat/webapps/ROOT/ /usr/local/tomcat/webapps/ROOT/

# Copiar as configurações do Tomcat
COPY tomcat/conf/ /usr/local/tomcat/conf/

# Copiar as bibliotecas necessárias
COPY tomcat/lib/ /usr/local/tomcat/lib/

# Criar diretório para dados persistentes
RUN mkdir -p /usr/local/tomcat/data && \
    chmod 777 /usr/local/tomcat/data

# Expor a porta 8080
EXPOSE 8080

# Comando para iniciar o Tomcat
ENTRYPOINT ["catalina.sh", "run"]
