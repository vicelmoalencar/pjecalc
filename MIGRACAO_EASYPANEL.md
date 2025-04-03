# Guia de Migração do PJECalc para Linux com Easypanel

## 1. Preparação dos Arquivos

### 1.1 Estrutura de Diretórios
Crie a seguinte estrutura no seu ambiente Linux:
```
/app
├── webapps
│   └── ROOT          # Aplicação principal
├── lib              # Bibliotecas
└── conf             # Configurações
```

### 1.2 Arquivos para Transferência
Transfira os seguintes arquivos/diretórios:

- `tomcat/webapps/ROOT/*` → `/app/webapps/ROOT/`
- `tomcat/lib/h2-1.3.154.jar` → `/app/lib/`
- `bin/lib/*.jar` → `/app/lib/`
- `tomcat/conf/*` → `/app/conf/`

## 2. Configuração no Easypanel

### 2.1 Criar Novo Serviço
1. Acesse o dashboard do Easypanel
2. Clique em "Create New Project"
3. Selecione "Java/Tomcat"
4. Configure:
   - Nome do Projeto: `pjecalc`
   - Versão do Java: 8
   - Porta: 9257
   - Memória: Mínimo 512MB recomendado

### 2.2 Variáveis de Ambiente
Configure as seguintes variáveis:
```
JAVA_OPTS=-Xmx512m -Xms256m
CATALINA_OPTS=-Dfile.encoding=UTF-8
```

## 3. Ajustes nos Arquivos de Configuração

### 3.1 server.xml
Ajuste o arquivo `/app/conf/server.xml`:
```xml
<Server port="9256" shutdown="SHUTDOWN">
    <!-- ... outros listeners ... -->
    
    <Service name="Catalina">
        <Connector port="9257" protocol="HTTP/1.1"
                   connectionTimeout="20000"
                   redirectPort="8443" />
        
        <!-- Remova ou comente o conector AJP se não for necessário -->
        <!--
        <Connector port="9258" protocol="AJP/1.3" redirectPort="8443" />
        -->
    </Service>
</Server>
```

### 3.2 catalina.properties
Em `/app/conf/catalina.properties`, ajuste os caminhos:
```properties
common.loader=/app/lib/*.jar
```

## 4. Banco de Dados

### 4.1 Configuração H2
Se houver arquivo de configuração do H2, ajuste o caminho para:
```
jdbc:h2:/app/data/pjecalc
```

## 5. Deploy

1. Compacte todos os arquivos preparados:
```bash
tar -czf pjecalc.tar.gz /app/*
```

2. No Easypanel:
   - Vá para o projeto pjecalc
   - Selecione "Upload Files"
   - Faça upload do arquivo tar.gz
   - Extraia no diretório /app

3. Configure permissões:
```bash
chmod -R 755 /app
chown -R tomcat:tomcat /app
```

## 6. Inicialização

1. No Easypanel, clique em "Start" para iniciar o serviço
2. Monitore os logs para verificar se a inicialização foi bem-sucedida
3. Acesse a aplicação através da URL fornecida pelo Easypanel

## 7. Verificação

Verifique:
- [ ] Aplicação acessível via navegador
- [ ] Banco de dados funcionando
- [ ] Logs sem erros
- [ ] Todas as funcionalidades principais operando corretamente

## 8. Backup

Configure backup automático:
1. No Easypanel, vá em "Backup Settings"
2. Configure backup diário dos diretórios:
   - /app/data (banco de dados)
   - /app/webapps/ROOT (aplicação)
   - /app/conf (configurações)

## Notas Importantes

1. Mantenha os arquivos originais do Windows como backup
2. Documente quaisquer alterações específicas feitas durante a migração
3. Teste todas as funcionalidades críticas após a migração
4. Mantenha um registro dos procedimentos realizados para referência futura
