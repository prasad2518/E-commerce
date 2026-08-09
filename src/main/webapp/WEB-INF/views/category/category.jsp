<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>
<%@ page import="com.fashionstore.model.Category"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
Category category = (Category) request.getAttribute("category");
String categoryName = (category != null) ? category.getCategoryName() : "Category";
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="catalog-page-container">
    <div class="catalog-header">
        <h1><%= categoryName %> Collection</h1>
        <p>Explore top styles and trending products in <%= categoryName %></p>
    </div>

    <!-- Category Filter Navigation Pills -->
    <div class="category-pills" style="margin-bottom: 30px;">
        <a href="${pageContext.request.contextPath}/products" class="pill">All Products</a>
        <a href="${pageContext.request.contextPath}/category?id=1" class="pill <%= (category != null && category.getCategoryId() == 1) ? "active" : "" %>">Men's Wear</a>
        <a href="${pageContext.request.contextPath}/category?id=2" class="pill <%= (category != null && category.getCategoryId() == 2) ? "active" : "" %>">Women's Collection</a>
        <a href="${pageContext.request.contextPath}/category?id=3" class="pill <%= (category != null && category.getCategoryId() == 3) ? "active" : "" %>">Kids Collection</a>
        <a href="${pageContext.request.contextPath}/category?id=4" class="pill <%= (category != null && category.getCategoryId() == 4) ? "active" : "" %>">Footwear</a>
        <a href="${pageContext.request.contextPath}/category?id=5" class="pill <%= (category != null && category.getCategoryId() == 5) ? "active" : "" %>">Accessories</a>
        <a href="${pageContext.request.contextPath}/category?id=6" class="pill <%= (category != null && category.getCategoryId() == 6) ? "active" : "" %>">Watches</a>
    </div>

    <section class="products-section">
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
                <p>No products found in <%= categoryName %> category.</p>
            </div>
        <%
        }
        %>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>