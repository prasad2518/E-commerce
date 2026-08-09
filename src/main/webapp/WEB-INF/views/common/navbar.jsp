<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fashionstore.model.User" %>
<%@ page import="com.fashionstore.dao.CartDAO" %>
<%@ page import="com.fashionstore.dao.impl.CartDAOImpl" %>
<%@ page import="com.fashionstore.model.CartItem" %>
<%@ page import="java.util.List" %>

<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
CartDAO navCartDAO = new CartDAOImpl();
List<CartItem> navCartItems = navCartDAO.getCartItems(1);
int cartCount = 0;
if (navCartItems != null) {
    for (CartItem ci : navCartItems) {
        cartCount += ci.getQuantity();
    }
}
%>

<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">
                <span class="logo-highlight">Fashion</span>Store
            </a>
        </div>

        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
            <li class="dropdown">
                <a href="${pageContext.request.contextPath}/products" class="dropdown-toggle">
                    Categories <span class="arrow">▾</span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/category?id=1">Men's Wear</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=2">Women's Wear</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=3">Kids Collection</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=4">Footwear</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=5">Accessories</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=6">Watches</a></li>
                </ul>
            </li>
            <li><a href="${pageContext.request.contextPath}/about">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        </ul>

        <div class="nav-right">
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
                <div class="search-wrapper">
                    <input type="text" name="keyword" placeholder="Search fashion products..." required>
                    <button type="submit" aria-label="Search">🔍</button>
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/cart" class="cart-icon-btn" title="View Cart">
                <span class="cart-symbol">🛒</span>
                <span class="cart-badge"><%= cartCount %></span>
            </a>

            <% if (loggedInUser != null) { %>
                <div class="user-dropdown dropdown">
                    <a href="#" class="user-greeting">
                        👤 <%= loggedInUser.getFullName() %> <span class="arrow">▾</span>
                    </a>
                    <ul class="dropdown-menu dropdown-right">
                        <li><a href="${pageContext.request.contextPath}/orders">📦 My Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout" class="logout-link">🚪 Logout</a></li>
                    </ul>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" class="nav-btn btn-secondary">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="nav-btn btn-primary">Register</a>
            <% } %>
        </div>
    </div>
</nav>