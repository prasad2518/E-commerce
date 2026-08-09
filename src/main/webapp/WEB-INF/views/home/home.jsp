<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Product" %>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!-- Real-World Clean Hero Banner Section -->
<section class="hero-banner-section">
    <div class="hero-banner-container">
        <a href="${pageContext.request.contextPath}/products" class="hero-banner-link" title="Discover Your Perfect Style - Shop Now">
            <img src="${pageContext.request.contextPath}/assets/images/hero_banner.jpg" 
                 alt="Discover Your Perfect Style - Premium Fashion" 
                 class="hero-banner-img">
        </a>
    </div>
</section>

<!-- Features Banner -->
<section class="features-bar">
    <div class="features-container">
        <div class="feature-item">
            <span class="feature-icon">🚚</span>
            <div>
                <h4>Free Shipping</h4>
                <p>On all orders above ₹999</p>
            </div>
        </div>
        <div class="feature-item">
            <span class="feature-icon">✨</span>
            <div>
                <h4>100% Authentic</h4>
                <p>Guaranteed original brands</p>
            </div>
        </div>
        <div class="feature-item">
            <span class="feature-icon">🔄</span>
            <div>
                <h4>Easy 30-Day Returns</h4>
                <p>Hassle-free replacement policy</p>
            </div>
        </div>
        <div class="feature-item">
            <span class="feature-icon">🔒</span>
            <div>
                <h4>Secure Payments</h4>
                <p>Multiple safe checkout options</p>
            </div>
        </div>
    </div>
</section>

<!-- Category Showcase Bar -->
<section class="category-pills-section">
    <div class="section-header">
        <h2>Shop By Category</h2>
        <p>Explore our wide array of curated fashion collections</p>
    </div>
    <div class="category-pills">
        <a href="${pageContext.request.contextPath}/products" class="pill active">All Products</a>
        <a href="${pageContext.request.contextPath}/category?id=1" class="pill">Men's Wear</a>
        <a href="${pageContext.request.contextPath}/category?id=2" class="pill">Women's Collection</a>
        <a href="${pageContext.request.contextPath}/category?id=3" class="pill">Kids Collection</a>
        <a href="${pageContext.request.contextPath}/category?id=4" class="pill">Footwear</a>
        <a href="${pageContext.request.contextPath}/category?id=5" class="pill">Accessories</a>
        <a href="${pageContext.request.contextPath}/category?id=6" class="pill">Watches</a>
    </div>
</section>

<!-- Main Products Grid -->
<section class="products-section">
    <div class="section-header">
        <h2>Latest Arrivals</h2>
        <p>Handpicked styles trending right now</p>
    </div>

    <div class="product-grid">
    <%
    if (products != null && !products.isEmpty()) {
        for (Product product : products) {
    %>
        <div class="product-card">
            <div class="card-image-wrapper">
                <span class="badge-tag"><%= product.getBrand() %></span>
                <img src="${pageContext.request.contextPath}/assets/images/products/<%= product.getImageUrl() %>"
                     alt="<%= product.getProductName() %>" class="product-img">
                <div class="card-overlay-actions">
                    <a href="${pageContext.request.contextPath}/product?id=<%= product.getProductId() %>" class="quick-view-btn">View Details</a>
                </div>
            </div>
            
            <div class="card-body">
                <span class="product-category-name"><%= product.getBrand() %></span>
                <h3 class="product-title"><%= product.getProductName() %></h3>
                <div class="card-price-row">
                    <span class="product-price">₹ <%= String.format("%.2f", product.getPrice()) %></span>
                </div>
                
                <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                    <input type="hidden" name="cartId" value="1">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn-add-cart">🛒 Add to Cart</button>
                </form>
            </div>
        </div>
    <%
        }
    } else {
    %>
        <div class="no-products">
            <p>No products available at the moment.</p>
        </div>
    <%
    }
    %>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />