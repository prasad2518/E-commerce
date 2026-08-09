<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="static-page-container">
    <div class="static-card">
        <h1>About FashionStore 🛍️</h1>
        <p class="subtitle">Bringing high fashion, quality, and style to your doorstep since 2026.</p>

        <div class="static-content">
            <h3>Our Mission</h3>
            <p>At FashionStore, we believe fashion is an extension of identity. Our mission is to provide premium, authentic apparel, footwear, watches, and accessories for Men, Women, and Kids at transparent and accessible prices.</p>

            <h3>Why Choose Us?</h3>
            <ul class="features-list">
                <li>✨ <strong>Curated Quality:</strong> Every item in our store is handpicked for craftsmanship and durability.</li>
                <li>⚡ <strong>Express Delivery:</strong> Rapid dispatch with real-time tracking for every purchase.</li>
                <li>🔒 <strong>100% Secure Shopping:</strong> Safe payment gateways and data protection guarantees.</li>
                <li>🔄 <strong>Easy Exchanges:</strong> 30-day hassle-free return and exchange policy.</li>
            </ul>

            <div class="cta-box">
                <a href="${pageContext.request.contextPath}/products" class="btn-hero-primary">Explore Our Catalog</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
