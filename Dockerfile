# Use a imagem base do Tomcat 7 com Java
FROM tomcat:7-jdk8

# Copiar o arquivo WAR da aplicação
COPY tomcat/webapps/ROOT/ /usr/local/tomcat/webapps/ROOT/

# Copiar as configurações do Tomcat
COPY tomcat/conf/ /usr/local/tomcat/conf/

# Copiar as bibliotecas necessárias
COPY tomcat/lib/ /usr/local/tomcat/lib/

# Expor a porta 8080
EXPOSE 8080

# Comando para iniciar o Tomcat
CMD ["catalina.sh", "run"]
