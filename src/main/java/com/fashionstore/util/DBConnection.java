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

        try {

            System.out.println("Loading Driver...");

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Driver Loaded");

            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("Database Connected");

        }catch (Exception e) {
            System.out.println("DB ERROR:");
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        return connection;
    }
}