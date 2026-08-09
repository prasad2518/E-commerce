<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionStore | Trendy Clothing & Accessories</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Main Design & Component CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css?v=1.2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css?v=1.2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css?v=1.2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css?v=1.2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-details.css?v=1.2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css?v=1.2">

    <!-- GLOBAL ABSOLUTE IMAGE OVERFLOW SAFEGUARDS -->
    <style>
        img {
            max-width: 100% !important;
            height: auto;
        }
        .cart-thumb, .checkout-item-thumb, img.cart-thumb, img.checkout-item-thumb {
            width: 60px !important;
            height: 75px !important;
            min-width: 60px !important;
            max-width: 60px !important;
            min-height: 75px !important;
            max-height: 75px !important;
            object-fit: cover !important;
            border-radius: 6px !important;
            flex-shrink: 0 !important;
            display: block !important;
        }
        .order-item-thumb, img.order-item-thumb {
            width: 55px !important;
            height: 55px !important;
            min-width: 55px !important;
            max-width: 55px !important;
            min-height: 55px !important;
            max-height: 55px !important;
            object-fit: cover !important;
            border-radius: 6px !important;
            flex-shrink: 0 !important;
            display: block !important;
        }
        .card img, .product-card img, img.product-img {
            max-width: 100% !important;
            max-height: 280px !important;
            width: 100% !important;
            height: 280px !important;
            object-fit: cover !important;
        }
    </style>
</head>
<body>
<div class="site-wrapper">