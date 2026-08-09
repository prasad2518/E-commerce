package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.model.CartItem;
import com.fashionstore.util.DBConnection;
public class CartDAOImpl implements CartDAO {
	
	
	// =====================================================
	// SQL QUERIES
	// =====================================================

	private static final String ADD_TO_CART_SQL = """
	        INSERT INTO cart_items
	        (
	            cart_id,
	            product_id,
	            quantity
	        )
	        VALUES (?, ?, ?)
	        """;

	private static final String GET_CART_ITEMS_SQL = """
	        SELECT *
	        FROM cart_items
	        WHERE cart_id = ?
	        """;

	private static final String UPDATE_CART_ITEM_QUANTITY_SQL = """
	        UPDATE cart_items
	        SET quantity = ?
	        WHERE cart_item_id = ?
	        """;

	private static final String REMOVE_CART_ITEM_SQL = """
	        DELETE FROM cart_items
	        WHERE cart_item_id = ?
	        """;

	private static final String CLEAR_CART_SQL = """
	        DELETE FROM cart_items
	        WHERE cart_id = ?
	        """;

	@Override
	public boolean addToCart(CartItem cartItem) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(ADD_TO_CART_SQL);
	    ) {

	        preparedStatement.setInt(1, cartItem.getCartId());
	        preparedStatement.setInt(2, cartItem.getProductId());
	        preparedStatement.setInt(3, cartItem.getQuantity());

	        return preparedStatement.executeUpdate() > 0;

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return false;
	}

	@Override
	public List<CartItem> getCartItems(int cartId) {

	    List<CartItem> cartItems = new ArrayList<>();

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_CART_ITEMS_SQL);
	    ) {

	        preparedStatement.setInt(1, cartId);

	        ResultSet resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {

	            cartItems.add(mapResultSetToCartItem(resultSet));

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return cartItems;
	}
	
	@Override
	public boolean updateCartItemQuantity(int cartItemId, int quantity) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(UPDATE_CART_ITEM_QUANTITY_SQL);
	    ) {

	        preparedStatement.setInt(1, quantity);
	        preparedStatement.setInt(2, cartItemId);

	        return preparedStatement.executeUpdate() > 0;

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return false;
	}
   
	@Override
	public boolean removeCartItem(int cartItemId) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(REMOVE_CART_ITEM_SQL);
	    ) {

	        preparedStatement.setInt(1, cartItemId);

	        return preparedStatement.executeUpdate() > 0;

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return false;
	}
	@Override
	public boolean clearCart(int cartId) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(CLEAR_CART_SQL);
	    ) {

	        preparedStatement.setInt(1, cartId);

	        return preparedStatement.executeUpdate() > 0;

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return false;
	}
	
	private CartItem mapResultSetToCartItem(ResultSet resultSet) throws SQLException {

	    CartItem cartItem = new CartItem();

	    cartItem.setCartItemId(resultSet.getInt("cart_item_id"));
	    cartItem.setCartId(resultSet.getInt("cart_id"));
	    cartItem.setProductId(resultSet.getInt("product_id"));
	    cartItem.setQuantity(resultSet.getInt("quantity"));

	    return cartItem;
	}
}