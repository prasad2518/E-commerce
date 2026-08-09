package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;
import com.fashionstore.util.DBConnection;
public class OrderDAOImpl implements OrderDAO {
	
	
	
	// =====================================================
	// SQL QUERIES
	// =====================================================

	private static final String PLACE_ORDER_SQL = """
	        INSERT INTO orders
	        (
	            user_id,
	            total_amount,
	            shipping_address,
	            payment_method,
	            order_status,
	            order_date
	        )
	        VALUES (?, ?, ?, ?, ?, ?)
	        """;

	private static final String GET_ORDERS_BY_USER_SQL = """
	        SELECT *
	        FROM orders
	        WHERE user_id = ?
	        ORDER BY order_date DESC
	        """;

	private static final String GET_ORDER_BY_ID_SQL = """
	        SELECT *
	        FROM orders
	        WHERE order_id = ?
	        """;

	private static final String GET_ORDER_ITEMS_SQL = """
	        SELECT *
	        FROM order_items
	        WHERE order_id = ?
	        """;

	@Override
	public boolean placeOrder(Order order) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(PLACE_ORDER_SQL);
	    ) {

	        preparedStatement.setInt(1, order.getUserId());
	        preparedStatement.setDouble(2, order.getTotalAmount());
	        preparedStatement.setString(3, order.getShippingAddress());
	        preparedStatement.setString(4, order.getPaymentMethod());
	        preparedStatement.setString(5, order.getOrderStatus());
	        preparedStatement.setString(6, order.getOrderDate());

	        return preparedStatement.executeUpdate() > 0;

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return false;
	}

	@Override
	public int createOrder(Order order, List<OrderItem> items) {
	    String insertOrderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, payment_method, order_status, order_date) VALUES (?, ?, ?, ?, ?, NOW())";
	    String insertItemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
	    
	    Connection connection = null;
	    try {
	        connection = DBConnection.getConnection();
	        connection.setAutoCommit(false);
	        
	        PreparedStatement psOrder = connection.prepareStatement(insertOrderSql, java.sql.Statement.RETURN_GENERATED_KEYS);
	        psOrder.setInt(1, order.getUserId());
	        psOrder.setDouble(2, order.getTotalAmount());
	        psOrder.setString(3, order.getShippingAddress());
	        psOrder.setString(4, order.getPaymentMethod());
	        psOrder.setString(5, order.getOrderStatus() != null ? order.getOrderStatus() : "Placed");
	        
	        int affected = psOrder.executeUpdate();
	        if (affected == 0) {
	            connection.rollback();
	            return -1;
	        }
	        
	        int generatedOrderId = -1;
	        try (ResultSet rs = psOrder.getGeneratedKeys()) {
	            if (rs.next()) {
	                generatedOrderId = rs.getInt(1);
	            }
	        }
	        
	        if (generatedOrderId == -1) {
	            connection.rollback();
	            return -1;
	        }
	        
	        if (items != null && !items.isEmpty()) {
	            PreparedStatement psItem = connection.prepareStatement(insertItemSql);
	            for (OrderItem item : items) {
	                psItem.setInt(1, generatedOrderId);
	                psItem.setInt(2, item.getProductId());
	                psItem.setInt(3, item.getQuantity());
	                psItem.setDouble(4, item.getPrice());
	                psItem.addBatch();
	            }
	            psItem.executeBatch();
	        }
	        
	        connection.commit();
	        return generatedOrderId;
	        
	    } catch (SQLException e) {
	        if (connection != null) {
	            try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
	        }
	        e.printStackTrace();
	    } finally {
	        if (connection != null) {
	            try { connection.setAutoCommit(true); connection.close(); } catch (SQLException ex) { ex.printStackTrace(); }
	        }
	    }
	    return -1;
	}

	@Override
	public List<Order> getOrdersByUser(int userId) {

	    List<Order> orders = new ArrayList<>();

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_ORDERS_BY_USER_SQL);
	    ) {

	        preparedStatement.setInt(1, userId);

	        ResultSet resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {

	            orders.add(mapResultSetToOrder(resultSet));

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return orders;
	}
	
	@Override
	public Order getOrderById(int orderId) {

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_ORDER_BY_ID_SQL);
	    ) {

	        preparedStatement.setInt(1, orderId);

	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {

	            return mapResultSetToOrder(resultSet);

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return null;
	}
	@Override
	public List<OrderItem> getOrderItems(int orderId) {

	    List<OrderItem> orderItems = new ArrayList<>();

	    try (
	            Connection connection = DBConnection.getConnection();

	            PreparedStatement preparedStatement =
	                    connection.prepareStatement(GET_ORDER_ITEMS_SQL);
	    ) {

	        preparedStatement.setInt(1, orderId);

	        ResultSet resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {

	            orderItems.add(mapResultSetToOrderItem(resultSet));

	        }

	    } catch (SQLException e) {

	        e.printStackTrace();

	    }

	    return orderItems;
	}
	
	
	private Order mapResultSetToOrder(ResultSet resultSet) throws SQLException {

	    Order order = new Order();

	    order.setOrderId(resultSet.getInt("order_id"));
	    order.setUserId(resultSet.getInt("user_id"));
	    order.setTotalAmount(resultSet.getDouble("total_amount"));
	    order.setShippingAddress(resultSet.getString("shipping_address"));
	    order.setPaymentMethod(resultSet.getString("payment_method"));
	    order.setOrderStatus(resultSet.getString("order_status"));
	    order.setOrderDate(resultSet.getString("order_date"));

	    return order;
	}
	
	
	private OrderItem mapResultSetToOrderItem(ResultSet resultSet) throws SQLException {

	    OrderItem orderItem = new OrderItem();

	    orderItem.setOrderItemId(resultSet.getInt("order_item_id"));
	    orderItem.setOrderId(resultSet.getInt("order_id"));
	    orderItem.setProductId(resultSet.getInt("product_id"));
	    orderItem.setQuantity(resultSet.getInt("quantity"));
	    orderItem.setPrice(resultSet.getDouble("price"));

	    return orderItem;
	}
}