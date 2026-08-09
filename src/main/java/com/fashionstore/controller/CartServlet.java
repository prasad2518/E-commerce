package com.fashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.model.CartItem;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int cartId = 1;

        List<CartItem> cartItems = cartDAO.getCartItems(cartId);

        for (CartItem item : cartItems) {

            Product product = productDAO.getProductById(item.getProductId());

            item.setProduct(product);
        }

        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("/WEB-INF/views/cart/cart.jsp")
               .forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartItem cartItem = new CartItem();

        cartItem.setCartId(cartId);
        cartItem.setProductId(productId);
        cartItem.setQuantity(quantity);

        boolean status = cartDAO.addToCart(cartItem);

        if (status) {
            response.sendRedirect(request.getContextPath() + "/cart");
        } else {
            response.sendRedirect(request.getContextPath()
                    + "/product?id=" + productId);
        }
    }
}