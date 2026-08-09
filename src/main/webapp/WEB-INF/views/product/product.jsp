<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.fashionstore.model.Product"%>

<%
Product product = (Product) request.getAttribute("product");
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="product-details-page">
<% if (product != null) { %>
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Home</a> &gt; 
        <a href="${pageContext.request.contextPath}/products">Products</a> &gt; 
        <span><%= product.getProductName() %></span>
    </div>

    <div class="product-details-card">
        <div class="details-image-section">
            <div class="main-image-box">
                <img src="${pageContext.request.contextPath}/assets/images/products/<%= product.getImageUrl() %>"
                     alt="<%= product.getProductName() %>" id="mainProductImg">
            </div>
        </div>

        <div class="details-info-section">
            <span class="brand-pill"><%= product.getBrand() %></span>
            <h1 class="details-title"><%= product.getProductName() %></h1>
            
            <div class="details-price-row">
                <span class="currency">₹</span>
                <span class="amount"><%= String.format("%.2f", product.getPrice()) %></span>
                <span class="tax-tag">Inclusive of all taxes</span>
            </div>

            <div class="details-divider"></div>

            <div class="description-box">
                <h3>Product Details</h3>
                <p><%= product.getDescription() != null ? product.getDescription() : "High quality item manufactured with premium craftsmanship and durable materials." %></p>
            </div>

            <form action="${pageContext.request.contextPath}/cart" method="post" class="details-cart-form">
                <input type="hidden" name="cartId" value="1">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">

                <div class="quantity-selector">
                    <label for="quantity">Quantity:</label>
                    <div class="qty-control">
                        <button type="button" onclick="decrementQty()">-</button>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" max="10" readonly>
                        <button type="button" onclick="incrementQty()">+</button>
                    </div>
                </div>

                <div class="action-buttons">
                    <button type="submit" class="btn-primary-cart">
                        🛒 Add To Shopping Cart
                    </button>
                    <a href="${pageContext.request.contextPath}/products" class="btn-secondary-back">
                        ← Back To Products
                    </a>
                </div>
            </form>

            <div class="product-perks">
                <div class="perk-item">✓ 100% Original Guarantee</div>
                <div class="perk-item">✓ Free Express Delivery Available</div>
                <div class="perk-item">✓ 30 Days Easy Return & Exchange</div>
            </div>
        </div>
    </div>
<% } else { %>
    <div class="no-products">
        <h2>Product Not Found</h2>
        <a href="${pageContext.request.contextPath}/products" class="btn-hero-primary">Back to Catalog</a>
    </div>
<% } %>
</div>

<script>
function incrementQty() {
    var q = document.getElementById('quantity');
    var val = parseInt(q.value) || 1;
    if (val < 10) q.value = val + 1;
}
function decrementQty() {
    var q = document.getElementById('quantity');
    var val = parseInt(q.value) || 1;
    if (val > 1) q.value = val - 1;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>