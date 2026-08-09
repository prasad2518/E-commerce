<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Product" %>
<%@ page import="com.fashionstore.model.Category" %>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
List<Category> categories = (List<Category>) request.getAttribute("categories");
Integer selectedCatId = (Integer) request.getAttribute("selectedCategoryId");
String selectedSort = (String) request.getAttribute("selectedSort");
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="catalog-page-container">
    <div class="catalog-header">
        <h1>All Fashion Products</h1>
        <p>Browse through our complete catalog of high quality apparel, footwear and accessories</p>
    </div>

    <!-- Filter and Sort Bar -->
    <div class="filter-sort-bar">
        <form action="${pageContext.request.contextPath}/products" method="get" class="filter-form">
            <div class="filter-group">
                <label for="categoryId">Category:</label>
                <select name="categoryId" id="categoryId" onchange="this.form.submit()">
                    <option value="">All Categories</option>
                    <%
                    if (categories != null) {
                        for (Category cat : categories) {
                            boolean isSel = (selectedCatId != null && selectedCatId == cat.getCategoryId());
                    %>
                        <option value="<%= cat.getCategoryId() %>" <%= isSel ? "selected" : "" %>>
                            <%= cat.getCategoryName() %>
                        </option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>

            <div class="filter-group">
                <label for="sort">Sort By Price:</label>
                <select name="sort" id="sort" onchange="this.form.submit()">
                    <option value="">Default Sorting</option>
                    <option value="low_high" <%= "low_high".equals(selectedSort) ? "selected" : "" %>>Price: Low to High</option>
                    <option value="high_low" <%= "high_low".equals(selectedSort) ? "selected" : "" %>>Price: High to Low</option>
                </select>
            </div>

            <% if (selectedCatId != null || (selectedSort != null && !selectedSort.isEmpty())) { %>
                <a href="${pageContext.request.contextPath}/products" class="btn-reset-filter">Clear Filters ✕</a>
            <% } %>
        </form>
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
                <p>No products match your selected criteria.</p>
            </div>
        <%
        }
        %>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
