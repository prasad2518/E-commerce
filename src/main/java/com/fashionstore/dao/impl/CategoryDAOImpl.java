package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.CategoryDAO;
import com.fashionstore.model.Category;
import com.fashionstore.util.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {
	
	
	
	private static final String GET_ALL_CATEGORIES_SQL = """
            SELECT *
            FROM categories
            ORDER BY category_name
            """;
	
	
	private static final String GET_CATEGORY_BY_ID_SQL = """
            SELECT *
            FROM categories
            WHERE category_id = ?
            """;



	@Override
	public List<Category> getAllCategories() {

	    List<Category> categories = new ArrayList<>();

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_ALL_CATEGORIES_SQL);
	    ) {

	        ResultSet resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {

	            categories.add(mapResultSetToCategory(resultSet));

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return categories;
	}
	
	@Override
	public Category getCategoryById(int categoryId) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_CATEGORY_BY_ID_SQL);
	    ) {

	        preparedStatement.setInt(1, categoryId);

	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {

	            return mapResultSetToCategory(resultSet);

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return null;
	}
	
	private Category mapResultSetToCategory(ResultSet resultSet) throws SQLException {

	    Category category = new Category();

	    category.setCategoryId(resultSet.getInt("category_id"));
	    category.setCategoryName(resultSet.getString("category_name"));
	    category.setDescription(resultSet.getString("description"));

	    return category;
	}
   
}