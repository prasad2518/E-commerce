package com.fashionstore.test;

import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

public class DBTest {

    public static void main(String[] args) {

    	ProductDAO productDAO = new ProductDAOImpl();

    	Product product = productDAO.getProductById(5);

    	if (product != null) {

    	    System.out.println("Product Name : " + product.getProductName());
    	    System.out.println("Brand        : " + product.getBrand());
    	    System.out.println("Price        : " + product.getPrice());

    	} else {

    	    System.out.println("Product Not Found");

    	}
    }

}