package com.fashionstore.controller;

import java.io.IOException;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
    	
    	System.out.println("HomeServlet initialized...");
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
    	
    	  System.out.println("HomeServlet is running...");


        // Get all products from the database
        List<Product> products = productDAO.getAllProducts();

        // Send the product list to the JSP page
        request.setAttribute("products", products);

        // Forward the request to home.jsp
        request.getRequestDispatcher("/WEB-INF/views/home/home.jsp")
        .forward(request, response);
    }
}