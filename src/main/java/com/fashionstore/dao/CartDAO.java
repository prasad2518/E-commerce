package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.CartItem;

public interface CartDAO {

    boolean addToCart(CartItem cartItem);

    List<CartItem> getCartItems(int cartId);

    boolean updateCartItemQuantity(int cartItemId, int quantity);

    boolean removeCartItem(int cartItemId);

    boolean clearCart(int cartId);

}