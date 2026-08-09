package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;

public interface OrderDAO {

    boolean placeOrder(Order order);

    int createOrder(Order order, List<OrderItem> items);

    List<Order> getOrdersByUser(int userId);

    Order getOrderById(int orderId);

    List<OrderItem> getOrderItems(int orderId);

}