<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Order"%>
<%@ page import="com.fashionstore.model.OrderItem"%>
<%@ page import="com.fashionstore.model.Product"%>

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="orders-page-container">
    <div class="orders-header">
        <h1>My Order History 📦</h1>
        <p>Track your past purchases and delivery status</p>
    </div>

    <% if (orders != null && !orders.isEmpty()) { %>
        <div class="orders-list">
            <% for (Order order : orders) { %>
                <div class="order-card">
                    <div class="order-card-header">
                        <div>
                            <span class="order-id">Order #FS-100<%= order.getOrderId() %></span>
                            <span class="order-date"><%= order.getOrderDate() != null ? order.getOrderDate() : "Recently Placed" %></span>
                        </div>
                        <div>
                            <span class="order-status-badge status-<%= order.getOrderStatus() != null ? order.getOrderStatus().toLowerCase() : "placed" %>">
                                <%= order.getOrderStatus() != null ? order.getOrderStatus() : "Placed" %>
                            </span>
                        </div>
                    </div>

                    <div class="order-card-body">
                        <div class="order-items-table">
                            <%
                            List<OrderItem> items = order.getOrderItems();
                            if (items != null) {
                                for (OrderItem item : items) {
                                    Product product = item.getProduct();
                            %>
                                <div class="order-item-row">
                                    <img src="${pageContext.request.contextPath}/assets/images/products/<%= product != null ? product.getImageUrl() : "default.jpg" %>"
                                         alt="Product" class="order-item-thumb"
                                         style="width: 55px !important; height: 55px !important; min-width: 55px !important; max-width: 55px !important; max-height: 55px !important; object-fit: cover !important; border-radius: 6px; flex-shrink: 0;">
                                    <div class="order-item-info">
                                        <h4><%= product != null ? product.getProductName() : "Product #" + item.getProductId() %></h4>
                                        <p>Qty: <%= item.getQuantity() %> × ₹ <%= String.format("%.2f", item.getPrice()) %></p>
                                    </div>
                                    <div class="order-item-subtotal">
                                        ₹ <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %>
                                    </div>
                                </div>
                            <%
                                }
                            }
                            %>
                        </div>
                    </div>

                    <div class="order-card-footer">
                        <div class="shipping-info">
                            <strong>Shipping To:</strong> <%= order.getShippingAddress() %>
                        </div>
                        <div class="order-total-price">
                            Total: <strong>₹ <%= String.format("%.2f", order.getTotalAmount()) %></strong>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="empty-orders-card">
            <div class="empty-icon">📦</div>
            <h2>No Orders Found</h2>
            <p>You haven't placed any orders yet.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn-hero-primary">Start Shopping Now</a>
        </div>
    <% } %>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
