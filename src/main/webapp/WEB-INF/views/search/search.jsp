<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fashionstore.model.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
String keyword = (String) request.getAttribute("keyword");
%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="catalog-page-container">
    <div class="catalog-header">
        <h1>Search Results for "<%= keyword != null ? keyword : "" %>"</h1>
        <p>Showing matching items from our fashion store catalog</p>
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
                <p>No products found matching "<%= keyword %>". Try searching for shirts, jeans, shoes, or watches.</p>
            </div>
        <%
        }
        %>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>