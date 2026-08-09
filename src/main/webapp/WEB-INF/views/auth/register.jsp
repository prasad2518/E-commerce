<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="register-container">

    <div class="register-card">

        <h2>Create Your Account</h2>

        <p class="register-subtitle">
            Join Fashion Store and start shopping
        </p>

        <form action="<%=request.getContextPath()%>/register" method="post">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input
                    type="text"
                    id="name"
                    name="name"
                    class="form-control"
                    placeholder="Enter your full name"
                    required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-control"
                    placeholder="Enter your email"
                    required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input
                    type="text"
                    id="phone"
                    name="phone"
                    class="form-control"
                    placeholder="Enter your phone number"
                    required>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <textarea
                    id="address"
                    name="address"
                    class="form-control"
                    rows="3"
                    placeholder="Enter your address"
                    required></textarea>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-control"
                    placeholder="Create a password"
                    required>
            </div>

            <button type="submit" class="register-btn">
                Create Account
            </button>

        </form>

        <div class="login-link">
            Already have an account?
            <a href="<%=request.getContextPath()%>/login">
                Login
            </a>
        </div>

    </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>