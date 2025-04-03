import org.apache.catalina.startup.Tomcat;

public class TomcatWrapper {
    public static void main(String[] args) throws Exception {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.setBaseDir(".");
        
        String webappDir = "/usr/local/tomcat/webapps/ROOT";
        tomcat.addWebapp("", webappDir);
        
        tomcat.start();
        
        // Manter o processo rodando
        Thread mainThread = Thread.currentThread();
        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() {
                try {
                    Thread.sleep(Long.MAX_VALUE);
                } catch (InterruptedException e) {
                    // Ignorar
                }
            }
        });
        
        try {
            mainThread.join();
        } catch (InterruptedException e) {
            // Ignorar
        }
    }
}
