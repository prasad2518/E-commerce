<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</div> <!-- closing .site-wrapper -->

<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-col">
            <h3 class="footer-brand"><span class="highlight">Fashion</span>Store</h3>
            <p>Your ultimate destination for premium clothing, footwear, watches, and accessories. Elevate your everyday style effortlessly.</p>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/products">All Products</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact & Support</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Categories</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/category?id=1">Men's Collection</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=2">Women's Collection</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=3">Kids Wear</a></li>
                <li><a href="${pageContext.request.contextPath}/category?id=6">Luxury Watches</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Customer Support</h4>
            <p><strong>Email:</strong> support@fashionstore.com</p>
            <p><strong>Phone:</strong> +91 98765 43210</p>
            <p><strong>Hours:</strong> Mon - Sat: 9:00 AM - 8:00 PM</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 FashionStore. All Rights Reserved. Crafted with care for style enthusiasts.</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>