package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fashionstore.dao.UserDAO;
import com.fashionstore.model.User;
import com.fashionstore.util.DBConnection;

public class UserDAOImpl implements UserDAO {

    // =====================================================
    // SQL QUERIES
    // =====================================================

    private static final String INSERT_USER_SQL = """
            INSERT INTO users
            (
                full_name,
                email,
                phone,
                address,
                password
            )
            VALUES (?, ?, ?, ?, ?)
            """;

    private static final String LOGIN_USER_SQL = """
            SELECT *
            FROM users
            WHERE email = ? AND password = ?
            """;

    private static final String GET_USER_BY_ID_SQL = """
            SELECT *
            FROM users
            WHERE user_id = ?
            """;

    private static final String UPDATE_USER_SQL = """
            UPDATE users
            SET full_name = ?,
                phone = ?,
                address = ?,
                password = ?
            WHERE user_id = ?
            """;

    // =====================================================
    // DAO METHODS
    // =====================================================

    @Override
    public boolean registerUser(User user) {

        try (
                Connection connection = DBConnection.getConnection();

                PreparedStatement preparedStatement =
                        connection.prepareStatement(INSERT_USER_SQL);
        ) {

            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getAddress());
            preparedStatement.setString(5, user.getPassword());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    @Override
    public User loginUser(String email, String password) {

        try (
                Connection connection = DBConnection.getConnection();

                PreparedStatement preparedStatement =
                        connection.prepareStatement(LOGIN_USER_SQL);
        ) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                User user = new User();

                user.setUserId(resultSet.getInt("user_id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setAddress(resultSet.getString("address"));
                user.setPassword(resultSet.getString("password"));

                return mapResultSetToUser(resultSet);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
        
       
    }
    
    
    @Override
    public User getUserById(int userId) {

        try (
                Connection connection = DBConnection.getConnection();

                PreparedStatement preparedStatement =
                        connection.prepareStatement(GET_USER_BY_ID_SQL);
        ) {

            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {

                User user = new User();

                user.setUserId(resultSet.getInt("user_id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setAddress(resultSet.getString("address"));
                user.setPassword(resultSet.getString("password"));
                return mapResultSetToUser(resultSet);
                           }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return null;
    }
    
    
    @Override
    public boolean updateUser(User user) {

        try (
                Connection connection = DBConnection.getConnection();

                PreparedStatement preparedStatement =
                        connection.prepareStatement(UPDATE_USER_SQL);
        ) {

            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getPhone());
            preparedStatement.setString(3, user.getAddress());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setInt(5, user.getUserId());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }
    
    private User mapResultSetToUser(ResultSet resultSet) throws SQLException {

        User user = new User();

        user.setUserId(resultSet.getInt("user_id"));
        user.setFullName(resultSet.getString("full_name"));
        user.setEmail(resultSet.getString("email"));
        user.setPhone(resultSet.getString("phone"));
        user.setAddress(resultSet.getString("address"));
        user.setPassword(resultSet.getString("password"));

        return user;
    }

    
    
  

}