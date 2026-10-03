# Use official Tomcat 10.1 image with OpenJDK 17
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat sample applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy web application files directly to ROOT application context
COPY src/main/webapp /usr/local/tomcat/webapps/ROOT

# Copy MySQL JDBC Connector to Tomcat's global lib directory
COPY src/main/webapp/WEB-INF/lib/mysql-connector-j-9.3.0.jar /usr/local/tomcat/lib/

# Expose HTTP port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
