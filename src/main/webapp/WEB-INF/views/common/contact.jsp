<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="static-page-container">
    <div class="static-card">
        <h1>Contact & Customer Support 📞</h1>
        <p class="subtitle">We'd love to hear from you. Get in touch with our dedicated support team.</p>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("successMessage") %>
            </div>
        <% } %>

        <div class="contact-grid">
            <div class="contact-info-box">
                <h3>Contact Details</h3>
                <p>📍 <strong>Address:</strong> FashionStore HQ, Tech City, Building 4, Hyderabad, India</p>
                <p>📧 <strong>Email:</strong> support@fashionstore.com</p>
                <p>📞 <strong>Phone:</strong> +91 98765 43210</p>
                <p>⏰ <strong>Working Hours:</strong> Monday - Saturday, 9:00 AM - 8:00 PM IST</p>
            </div>

            <form action="${pageContext.request.contextPath}/contact" method="post" class="contact-form">
                <h3>Send Us a Message</h3>
                <div class="form-group">
                    <label for="cname">Your Name</label>
                    <input type="text" id="cname" name="name" required class="form-input" placeholder="Enter your full name">
                </div>
                <div class="form-group">
                    <label for="cemail">Email Address</label>
                    <input type="email" id="cemail" name="email" required class="form-input" placeholder="Enter your email address">
                </div>
                <div class="form-group">
                    <label for="cmessage">Message</label>
                    <textarea id="cmessage" name="message" rows="4" required class="form-input" placeholder="How can we assist you?"></textarea>
                </div>
                <button type="submit" class="btn-hero-primary">Submit Inquiry</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
