<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.CartItem"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.User"%>

<%
List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
Double totalAmountObj = (Double) request.getAttribute("totalAmount");
double totalAmount = totalAmountObj != null ? totalAmountObj : 0.0;
User loggedInUser = (User) session.getAttribute("loggedInUser");

String defaultName = loggedInUser != null ? loggedInUser.getFullName() : "";
String defaultPhone = loggedInUser != null ? loggedInUser.getPhone() : "";
String defaultAddress = loggedInUser != null ? loggedInUser.getAddress() : "";
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="checkout-page-container">
    <div class="checkout-header">
        <h1>Checkout & Shipping</h1>
        <p>Complete your delivery details and choose a payment method</p>
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <div class="checkout-layout">
        <div class="checkout-form-section">
            <form action="${pageContext.request.contextPath}/checkout" method="post" class="checkout-form">
                <h2>1. Delivery Address</h2>
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= defaultName %>" placeholder="Enter recipient name" required class="form-input">
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" value="<%= defaultPhone %>" placeholder="Enter 10-digit mobile number" required class="form-input">
                </div>

                <div class="form-group">
                    <label for="address">Shipping Address</label>
                    <textarea id="address" name="address" rows="3" placeholder="Flat No, Building, Street, Area, City, Pincode" required class="form-input"><%= defaultAddress %></textarea>
                </div>

                <h2>2. Payment Method</h2>
                <div class="payment-options">
                    <label class="payment-card selected">
                        <input type="radio" name="paymentMethod" value="Cash on Delivery" checked>
                        <div class="payment-info">
                            <strong>💵 Cash on Delivery (COD)</strong>
                            <p>Pay in cash upon receiving your order</p>
                        </div>
                    </label>

                    <label class="payment-card">
                        <input type="radio" name="paymentMethod" value="UPI / Online Payment">
                        <div class="payment-info">
                            <strong>📱 Instant UPI / Net Banking</strong>
                            <p>Pay securely via GPay, PhonePe, Paytm, or Card</p>
                        </div>
                    </label>
                </div>

                <button type="submit" class="btn-place-order">
                    Place Order Now (₹ <%= String.format("%.2f", totalAmount) %>)
                </button>
            </form>
        </div>

        <div class="checkout-summary-section">
            <div class="summary-card">
                <h3>Order Items (<%= cartItems != null ? cartItems.size() : 0 %>)</h3>
                <div class="checkout-items-list">
                    <%
                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                            Product product = item.getProduct();
                            if (product != null) {
                    %>
                    <div class="checkout-item">
                        <img src="${pageContext.request.contextPath}/assets/images/products/<%= product.getImageUrl() %>"
                             alt="<%= product.getProductName() %>" class="checkout-item-thumb"
                             style="width: 60px !important; height: 75px !important; min-width: 60px !important; max-width: 60px !important; max-height: 75px !important; object-fit: cover !important; border-radius: 6px; flex-shrink: 0;">
                        <div class="checkout-item-details">
                            <h4><%= product.getProductName() %></h4>
                            <p>Qty: <%= item.getQuantity() %> × ₹ <%= String.format("%.2f", product.getPrice()) %></p>
                        </div>
                        <div class="checkout-item-price">
                            ₹ <%= String.format("%.2f", product.getPrice() * item.getQuantity()) %>
                        </div>
                    </div>
                    <%
                            }
                        }
                    }
                    %>
                </div>

                <div class="summary-divider"></div>
                <div class="summary-total-line">
                    <span>Grand Total:</span>
                    <span>₹ <%= String.format("%.2f", totalAmount) %></span>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>