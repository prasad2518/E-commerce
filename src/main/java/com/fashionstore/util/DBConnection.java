package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Database URL
    private static final String URL = "jdbc:mysql://localhost:3306/fashion_store";

    // Database Username
    private static final String USERNAME = "root";

    // Database Password
    private static final String PASSWORD = "Prasad@18";

    private DBConnection() {

    }

    public static Connection getConnection() {

        System.out.println("******** DBConnection METHOD CALLED ********");

        Connection connection = null;

        String envUrl = System.getenv("DB_URL");
        if (envUrl == null || envUrl.trim().isEmpty()) {
            envUrl = System.getenv("MYSQL_URL");
        }
        if (envUrl == null || envUrl.trim().isEmpty()) {
            envUrl = System.getenv("DATABASE_URL");
        }

        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String dbName = System.getenv("MYSQLDATABASE");

        String envUser = System.getenv("DB_USER");
        if (envUser == null || envUser.trim().isEmpty()) {
            envUser = System.getenv("MYSQLUSER");
        }

        String envPass = System.getenv("DB_PASSWORD");
        if (envPass == null || envPass.trim().isEmpty()) {
            envPass = System.getenv("MYSQLPASSWORD");
        }

        String dbUrl;
        if (envUrl != null && !envUrl.trim().isEmpty()) {
            dbUrl = envUrl.trim();
            if (dbUrl.startsWith("mysql://")) {
                dbUrl = dbUrl.replace("mysql://", "jdbc:mysql://");
            }
        } else if (host != null && !host.trim().isEmpty()) {
            String p = (port != null && !port.trim().isEmpty()) ? port.trim() : "3306";
            String db = (dbName != null && !dbName.trim().isEmpty()) ? dbName.trim() : "fashion_store";
            dbUrl = "jdbc:mysql://" + host.trim() + ":" + p + "/" + db + "?allowPublicKeyRetrieval=true&useSSL=false";
        } else {
            dbUrl = URL;
        }

        String dbUser = (envUser != null && !envUser.trim().isEmpty()) ? envUser.trim() : USERNAME;
        String dbPass = (envPass != null) ? envPass : PASSWORD;

        try {

            System.out.println("Loading Driver...");

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Driver Loaded. Connecting to: " + dbUrl);

            connection = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            System.out.println("Database Connected");

        } catch (Exception e) {
            System.out.println("DB ERROR:");
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return connection;
    }
}