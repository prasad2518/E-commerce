package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.model.Product;
import com.fashionstore.util.DBConnection;


public class ProductDAOImpl implements ProductDAO {


    // =====================================================
    // SQL QUERIES
    // =====================================================

    private static final String GET_ALL_PRODUCTS_SQL = """
            SELECT *
            FROM products
            ORDER BY product_id ASC
            """;


    private static final String GET_PRODUCT_BY_ID_SQL = """
            SELECT *
            FROM products
            WHERE product_id = ?
            """;


    private static final String GET_PRODUCTS_BY_CATEGORY_SQL = """
            SELECT *
            FROM products
            WHERE category_id = ?
             ORDER BY product_id ASC
            """;


    private static final String SEARCH_PRODUCTS_SQL = """
            SELECT *
            FROM products
            WHERE product_name LIKE ?
            OR brand LIKE ?
            """;



    // =====================================================
    // GET ALL PRODUCTS
    // =====================================================

    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_ALL_PRODUCTS_SQL);
             ResultSet resultSet =
                     preparedStatement.executeQuery()) {


            while(resultSet.next()) {

                Product product = mapProduct(resultSet);

                products.add(product);
            }


        } catch(SQLException e) {

            e.printStackTrace();

        }


        return products;
    }




    // =====================================================
    // GET PRODUCT BY ID
    // =====================================================

    @Override
    public Product getProductById(int id) {

        Product product = null;


        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_PRODUCT_BY_ID_SQL)) {


            preparedStatement.setInt(1, id);


            ResultSet resultSet =
                    preparedStatement.executeQuery();



            if(resultSet.next()) {

                product = mapProduct(resultSet);

            }


        } catch(SQLException e) {

            e.printStackTrace();

        }


        return product;
    }





    // =====================================================
    // GET PRODUCTS BY CATEGORY
    // =====================================================

    @Override
    public List<Product> getProductsByCategory(int categoryId) {


        List<Product> products = new ArrayList<>();


        try(Connection connection = DBConnection.getConnection();
            PreparedStatement preparedStatement =
                    connection.prepareStatement(GET_PRODUCTS_BY_CATEGORY_SQL)) {


            preparedStatement.setInt(1, categoryId);


            ResultSet resultSet =
                    preparedStatement.executeQuery();



            while(resultSet.next()) {

                Product product = mapProduct(resultSet);

                products.add(product);

            }


        } catch(SQLException e) {

            e.printStackTrace();

        }


        return products;

    }





    // =====================================================
    // SEARCH PRODUCTS
    // =====================================================

    @Override
    public List<Product> searchProducts(String keyword) {


        List<Product> products = new ArrayList<>();


        try(Connection connection = DBConnection.getConnection();
            PreparedStatement preparedStatement =
                    connection.prepareStatement(SEARCH_PRODUCTS_SQL)) {



            preparedStatement.setString(1, "%" + keyword + "%");

            preparedStatement.setString(2, "%" + keyword + "%");



            ResultSet resultSet =
                    preparedStatement.executeQuery();



            while(resultSet.next()) {


                Product product = mapProduct(resultSet);


                products.add(product);

            }



        } catch(SQLException e) {

            e.printStackTrace();

        }


        return products;

    }





    // =====================================================
    // COMMON PRODUCT MAPPING METHOD
    // =====================================================

    private Product mapProduct(ResultSet resultSet) throws SQLException {


        Product product = new Product();


        product.setProductId(
                resultSet.getInt("product_id")
        );


        product.setCategoryId(
                resultSet.getInt("category_id")
        );


        product.setProductName(
                resultSet.getString("product_name")
        );


        product.setBrand(
                resultSet.getString("brand")
        );


        product.setDescription(
                resultSet.getString("description")
        );


        product.setPrice(
                resultSet.getDouble("price")
        );


        product.setImageUrl(
                resultSet.getString("image_url")
        );


        return product;

    }

}