@echo
set local=%~dp0
cd %local%
start bin\jre\bin\javaw -splash:pjecalc_splash.gif -Duser.timezone=GMT-3 -Dfile.encoding=ISO-8859-1 -Dseguranca.pjecalc.tokenServicos=pW4jZ4g9VM5MCy6FnB5pEfQe -Dseguranca.pjekz.servico.contexto="https://pje.trtXX.jus.br/pje-seguranca" -Xms1024m -Xmx2048m -XX:MaxPermSize=512m -jar bin\pjecalc.jar
