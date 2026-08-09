package com.fashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;
import com.fashionstore.model.Product;
import com.fashionstore.model.User;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int cartId = 1;
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);
        double totalAmount = 0.0;

        for (CartItem item : cartItems) {
            Product product = productDAO.getProductById(item.getProductId());
            item.setProduct(product);
            if (product != null) {
                totalAmount += product.getPrice() * item.getQuantity();
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("/WEB-INF/views/order/checkout.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        int userId = (user != null) ? user.getUserId() : 1;

        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "Cash on Delivery";
        }

        int cartId = 1;
        List<CartItem> cartItems = cartDAO.getCartItems(cartId);

        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double totalAmount = 0.0;
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem item : cartItems) {
            Product product = productDAO.getProductById(item.getProductId());
            if (product != null) {
                double itemPrice = product.getPrice();
                totalAmount += itemPrice * item.getQuantity();

                OrderItem orderItem = new OrderItem();
                orderItem.setProductId(product.getProductId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(itemPrice);
                orderItems.add(orderItem);
            }
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(address + " (Contact: " + fullName + ", Ph: " + phone + ")");
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Placed");

        int orderId = orderDAO.createOrder(order, orderItems);

        if (orderId > 0) {
            cartDAO.clearCart(cartId);
            request.setAttribute("orderId", orderId);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/WEB-INF/views/order/order-confirmation.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Failed to place order. Please try again.");
            doGet(request, response);
        }
    }
}