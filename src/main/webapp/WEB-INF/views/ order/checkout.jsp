<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="login-container">

    <h2>Checkout</h2>

    <form action="<%=request.getContextPath()%>/checkout" method="post">

        <div class="form-group">
            <label>Full Name</label>
            <input
                type="text"
                name="fullName"
                required>
        </div>

        <div class="form-group">
            <label>Delivery Address</label>
            <textarea
                name="address"
                rows="4"
                required></textarea>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <input
                type="text"
                name="phone"
                required>
        </div>

        <button type="submit">
            Place Order
        </button>

    </form>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>