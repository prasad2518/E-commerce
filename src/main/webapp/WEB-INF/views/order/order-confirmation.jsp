<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
Integer orderId = (Integer) request.getAttribute("orderId");
Double totalAmountObj = (Double) request.getAttribute("totalAmount");
double totalAmount = totalAmountObj != null ? totalAmountObj : 0.0;
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="confirmation-page-container">
    <div class="confirmation-card">
        <div class="success-icon">🎉</div>
        <h1>Order Placed Successfully!</h1>
        <p class="success-sub">Thank you for shopping with FashionStore. Your order has been registered.</p>

        <div class="order-details-box">
            <div class="info-row">
                <span>Order Reference:</span>
                <strong>#FS-100<%= orderId != null ? orderId : 1 %></strong>
            </div>
            <div class="info-row">
                <span>Total Paid:</span>
                <strong>₹ <%= String.format("%.2f", totalAmount) %></strong>
            </div>
            <div class="info-row">
                <span>Estimated Delivery:</span>
                <strong>Within 3-5 Business Days</strong>
            </div>
        </div>

        <div class="confirmation-actions">
            <a href="${pageContext.request.contextPath}/orders" class="btn-hero-primary">View My Orders</a>
            <a href="${pageContext.request.contextPath}/products" class="btn-hero-secondary">Continue Shopping</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
