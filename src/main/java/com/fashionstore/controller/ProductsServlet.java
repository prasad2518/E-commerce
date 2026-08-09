package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionstore.dao.CategoryDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Category;
import com.fashionstore.model.Product;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String catIdParam = request.getParameter("categoryId");
        String sortParam = request.getParameter("sort");

        List<Product> products;
        if (catIdParam != null && !catIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(catIdParam);
                products = productDAO.getProductsByCategory(categoryId);
                request.setAttribute("selectedCategoryId", categoryId);
            } catch (NumberFormatException e) {
                products = productDAO.getAllProducts();
            }
        } else {
            products = productDAO.getAllProducts();
        }

        if ("low_high".equals(sortParam)) {
            products = products.stream()
                    .sorted((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()))
                    .collect(Collectors.toList());
            request.setAttribute("selectedSort", "low_high");
        } else if ("high_low".equals(sortParam)) {
            products = products.stream()
                    .sorted((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()))
                    .collect(Collectors.toList());
            request.setAttribute("selectedSort", "high_low");
        }

        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("products", products);

        request.getRequestDispatcher("/WEB-INF/views/product/products.jsp")
               .forward(request, response);
    }
}
