<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.CartItem"%>
<%@ page import="com.fashionstore.model.Product"%>

<%
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
double grandTotal = 0;
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="cart-page-container">
    <div class="cart-header">
        <h1>Shopping Cart 🛒</h1>
        <p>Review items in your bag before proceeding to checkout</p>
    </div>

    <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="cart-layout">
            <div class="cart-items-section">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Brand</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for (CartItem item : cartItems) {
                            Product product = item.getProduct();
                            if (product != null) {
                                double subtotal = product.getPrice() * item.getQuantity();
                                grandTotal += subtotal;
                        %>
                        <tr>
                            <td class="product-col">
                                <img src="${pageContext.request.contextPath}/assets/images/products/<%= product.getImageUrl() %>"
                                     alt="<%= product.getProductName() %>" class="cart-thumb"
                                     style="width: 60px !important; height: 75px !important; min-width: 60px !important; max-width: 60px !important; max-height: 75px !important; object-fit: cover !important; border-radius: 6px; flex-shrink: 0;">
                                <div class="cart-item-title"><%= product.getProductName() %></div>
                            </td>
                            <td><span class="brand-tag"><%= product.getBrand() %></span></td>
                            <td class="price-cell">₹ <%= String.format("%.2f", product.getPrice()) %></td>
                            <td><span class="qty-badge"><%= item.getQuantity() %></span></td>
                            <td class="subtotal-cell">₹ <%= String.format("%.2f", subtotal) %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/remove-cart-item?id=<%= item.getCartItemId() %>"
                                   class="btn-remove" onclick="return confirm('Remove item from cart?')">
                                    🗑 Remove
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                </table>
                <div class="cart-actions-row">
                    <a href="${pageContext.request.contextPath}/products" class="btn-continue-shopping">
                        ← Continue Shopping
                    </a>
                </div>
            </div>

            <div class="cart-summary-card">
                <h3>Order Summary</h3>
                <div class="summary-line">
                    <span>Items Subtotal</span>
                    <span>₹ <%= String.format("%.2f", grandTotal) %></span>
                </div>
                <div class="summary-line">
                    <span>Shipping</span>
                    <span class="free-shipping">FREE</span>
                </div>
                <div class="summary-line">
                    <span>Taxes</span>
                    <span>Included</span>
                </div>
                <div class="summary-divider"></div>
                <div class="summary-total-line">
                    <span>Total Amount</span>
                    <span>₹ <%= String.format("%.2f", grandTotal) %></span>
                </div>

                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">
                    Proceed to Checkout →
                </a>
            </div>
        </div>
    <% } else { %>
        <div class="empty-cart-card">
            <div class="empty-icon">🛒</div>
            <h2>Your Shopping Cart is Empty</h2>
            <p>Looks like you haven't added any fashion items to your cart yet.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn-hero-primary">Start Shopping Now</a>
        </div>
    <% } %>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>