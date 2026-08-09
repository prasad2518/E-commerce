package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;
import com.fashionstore.model.Product;
import com.fashionstore.model.User;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        int userId = (user != null) ? user.getUserId() : 1;

        List<Order> orders = orderDAO.getOrdersByUser(userId);

        for (Order order : orders) {
            List<OrderItem> items = orderDAO.getOrderItems(order.getOrderId());
            for (OrderItem item : items) {
                Product p = productDAO.getProductById(item.getProductId());
                item.setProduct(p);
            }
            order.setOrderItems(items);
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/views/order/orders.jsp")
               .forward(request, response);
    }
}
