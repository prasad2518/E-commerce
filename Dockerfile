# Use official Tomcat 10.1 with Java 17 runtime
FROM tomcat:10.1-jdk17-slim

# Clean up default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Copy web application static assets, JSPs, and compiled classes to ROOT application context
COPY src/main/webapp /usr/local/tomcat/webapps/ROOT

# Copy MySQL JDBC Connector JAR into Tomcat's global class path library
COPY src/main/webapp/WEB-INF/lib/mysql-connector-j-9.3.0.jar /usr/local/tomcat/lib/

# Expose HTTP port 8080
EXPOSE 8080

# Launch Catalina Tomcat Server
CMD ["catalina.sh", "run"]
