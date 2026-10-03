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
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASSWORD");

        String dbUrl = (envUrl != null && !envUrl.trim().isEmpty()) ? envUrl.trim() : URL;
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