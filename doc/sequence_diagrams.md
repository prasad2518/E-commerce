# System Sequence Diagrams

This document contains end-to-end **Mermaid Sequence Diagrams** illustrating the message passings, request-response execution flows, database calls, session bindings, and view forwards for every operational feature in **FashionStore**.

---

## 1. User Registration Flow

Illustrates a new user registering an account via `RegisterServlet`.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant RegSvc as RegisterServlet
    participant UDAO as UserDAOImpl
    participant DBC as DBConnection
    participant DB as MySQL Database
    participant View as register.jsp / login.jsp

    User->>RegSvc: GET /register
    RegSvc->>View: Forward request to /WEB-INF/views/auth/register.jsp
    View-->>User: Render Registration Form HTML

    User->>RegSvc: POST /register (name, email, phone, address, password)
    RegSvc->>RegSvc: Instantiate User entity & populate fields
    RegSvc->>UDAO: registerUser(user)
    UDAO->>DBC: getConnection()
    DBC->>DB: DriverManager.getConnection()
    DB-->>DBC: Return Connection
    DBC-->>UDAO: Connection instance
    UDAO->>DB: Execute Prepared INSERT INTO users (...) VALUES (...)
    
    alt Registration Successful
        DB-->>UDAO: Rows Affected > 0 (Success)
        UDAO-->>RegSvc: return true
        RegSvc-->>User: HTTP 302 Redirect to /login
    else Registration Failed / Email Duplicate
        DB-->>UDAO: SQLException / Rows Affected = 0
        UDAO-->>RegSvc: return false
        RegSvc->>RegSvc: setAttribute("errorMessage", "Registration Failed...")
        RegSvc->>View: Forward to /WEB-INF/views/auth/register.jsp
        View-->>User: Render Registration Form with Error Alert
    end
```

---

## 2. User Login & Authentication Flow

Illustrates user credential authentication, HTTP session creation, and state persistence.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant LogSvc as LoginServlet
    participant UDAO as UserDAOImpl
    participant DBC as DBConnection
    participant DB as MySQL Database
    participant Session as HttpSession
    participant Home as HomeServlet / home.jsp

    User->>LogSvc: GET /login
    LogSvc-->>User: Forward & Render /WEB-INF/views/auth/login.jsp

    User->>LogSvc: POST /login (email, password)
    LogSvc->>UDAO: loginUser(email, password)
    UDAO->>DBC: getConnection()
    DBC->>DB: DriverManager.getConnection()
    UDAO->>DB: PreparedStatement: SELECT * FROM users WHERE email=? AND password=?
    DB-->>UDAO: ResultSet row

    alt Valid Credentials
        UDAO->>UDAO: mapResultSetToUser(resultSet)
        UDAO-->>LogSvc: Return User object
        LogSvc->>Session: request.getSession().setAttribute("loggedInUser", user)
        LogSvc-->>User: HTTP 302 Redirect to /home
        User->>Home: GET /home (with Session Cookie)
        Home-->>User: Render Home Dashboard
    else Invalid Credentials
        UDAO-->>LogSvc: Return null
        LogSvc->>LogSvc: setAttribute("errorMessage", "Invalid Email or Password")
        LogSvc-->>User: Forward to login.jsp with Error Message
    end
```

---

## 3. Product Catalog Browsing & Category Filtering Flow

Illustrates fetching product catalogs, filtering by category, and dynamic in-memory price sorting.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant ProdSvc as ProductsServlet
    participant PDAO as ProductDAOImpl
    participant CDAO as CategoryDAOImpl
    participant DB as MySQL Database
    participant View as products.jsp

    User->>ProdSvc: GET /products?categoryId=2&sort=low_high
    
    alt categoryId parameter provided
        ProdSvc->>PDAO: getProductsByCategory(2)
        PDAO->>DB: SELECT * FROM products WHERE category_id=2 ORDER BY product_id ASC
        DB-->>PDAO: ResultSet product rows
        PDAO-->>ProdSvc: List<Product>
    else categoryId omitted
        ProdSvc->>PDAO: getAllProducts()
        PDAO->>DB: SELECT * FROM products ORDER BY product_id ASC
        DB-->>PDAO: ResultSet product rows
        PDAO-->>ProdSvc: List<Product>
    end

    alt sort == "low_high" or "high_low"
        ProdSvc->>ProdSvc: Apply Stream .sorted() by price
    end

    ProdSvc->>CDAO: getAllCategories()
    CDAO->>DB: SELECT * FROM categories ORDER BY category_name
    DB-->>CDAO: ResultSet category rows
    CDAO-->>ProdSvc: List<Category>

    ProdSvc->>ProdSvc: setAttribute("products", products)
    ProdSvc->>ProdSvc: setAttribute("categories", categories)
    ProdSvc->>View: Forward to /WEB-INF/views/product/products.jsp
    View-->>User: Render Filtered & Sorted Products Page HTML
```

---

## 4. Product Search Flow

Illustrates searching for products using partial matching across product title and brand.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant SearchSvc as SearchServlet
    participant PDAO as ProductDAOImpl
    participant DB as MySQL Database
    participant View as search.jsp

    User->>SearchSvc: GET /search?keyword=jeans
    SearchSvc->>PDAO: searchProducts("jeans")
    PDAO->>DB: SELECT * FROM products WHERE product_name LIKE '%jeans%' OR brand LIKE '%jeans%'
    DB-->>PDAO: ResultSet product rows
    PDAO->>PDAO: mapProduct(resultSet) for each row
    PDAO-->>SearchSvc: List<Product>
    SearchSvc->>SearchSvc: setAttribute("products", products)
    SearchSvc->>SearchSvc: setAttribute("keyword", "jeans")
    SearchSvc->>View: Forward to /WEB-INF/views/search/search.jsp
    View-->>User: Render Search Results Page
```

---

## 5. Shopping Cart Management Flow

Illustrates adding items to cart, loading cart state with nested products, and deleting cart line items.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant CartSvc as CartServlet
    participant DelSvc as RemoveCartItemServlet
    participant CartDAO as CartDAOImpl
    participant PDAO as ProductDAOImpl
    participant DB as MySQL Database
    participant View as cart.jsp

    rect rgb(240, 248, 255)
        note over User, CartSvc: Action: Add Product to Shopping Cart
        User->>CartSvc: POST /cart (cartId=1, productId=101, quantity=2)
        CartSvc->>CartDAO: addToCart(cartItem)
        CartDAO->>DB: INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (1, 101, 2)
        DB-->>CartDAO: Row inserted
        CartDAO-->>CartSvc: return true
        CartSvc-->>User: HTTP 302 Redirect to /cart
    end

    rect rgb(255, 250, 240)
        note over User, CartSvc: Action: View Shopping Cart Contents
        User->>CartSvc: GET /cart
        CartSvc->>CartDAO: getCartItems(cartId=1)
        CartDAO->>DB: SELECT * FROM cart_items WHERE cart_id = 1
        DB-->>CartDAO: List<CartItem>
        CartDAO-->>CartSvc: List<CartItem>
        
        loop For each CartItem in list
            CartSvc->>PDAO: getProductById(item.getProductId())
            PDAO->>DB: SELECT * FROM products WHERE product_id = ?
            DB-->>PDAO: Product entity
            PDAO-->>CartSvc: Product entity
            CartSvc->>CartSvc: item.setProduct(product)
        end

        CartSvc->>View: Forward to /WEB-INF/views/cart/cart.jsp
        View-->>User: Render Cart Page with Subtotals & Products
    end

    rect rgb(255, 240, 245)
        note over User, DelSvc: Action: Remove Item from Cart
        User->>DelSvc: GET /remove-cart-item?id=5
        DelSvc->>CartDAO: removeCartItem(5)
        CartDAO->>DB: DELETE FROM cart_items WHERE cart_item_id = 5
        DB-->>CartDAO: Row deleted
        CartDAO-->>DelSvc: return true
        DelSvc-->>User: HTTP 302 Redirect to /cart
    end
```

---

## 6. Transactional Order Checkout & Placement Flow

Illustrates transactional order creation, batch inserting line items, auto-commit management, rollback safety, and cart clearing.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant CheckSvc as CheckoutServlet
    participant CartDAO as CartDAOImpl
    participant PDAO as ProductDAOImpl
    participant ODAO as OrderDAOImpl
    participant DBC as DBConnection
    participant DB as MySQL Database
    participant ConfirmView as order-confirmation.jsp

    User->>CheckSvc: POST /checkout (fullName, address, phone, paymentMethod)
    CheckSvc->>CheckSvc: Resolve userId from Session (or default 1)
    CheckSvc->>CartDAO: getCartItems(cartId=1)
    CartDAO->>DB: SELECT * FROM cart_items WHERE cart_id = 1
    DB-->>CartDAO: List<CartItem>
    CartDAO-->>CheckSvc: List<CartItem>

    loop Compute totals & build OrderItems
        CheckSvc->>PDAO: getProductById(item.getProductId())
        PDAO->>DB: SELECT * FROM products WHERE product_id = ?
        DB-->>PDAO: Product entity
        PDAO-->>CheckSvc: Product entity
        CheckSvc->>CheckSvc: totalAmount += product.price * item.quantity
        CheckSvc->>CheckSvc: Create OrderItem(productId, quantity, price)
    end

    CheckSvc->>ODAO: createOrder(order, orderItems)
    
    note over ODAO, DB: Begin JDBC Database Transaction
    ODAO->>DBC: getConnection()
    DBC-->>ODAO: Connection object
    ODAO->>DB: connection.setAutoCommit(false)
    
    ODAO->>DB: INSERT INTO orders (user_id, total_amount, shipping_address, payment_method, order_status, order_date) VALUES (?, ?, ?, ?, ?, NOW())
    DB-->>ODAO: Return Generated Keys (generatedOrderId)

    alt Order Insertion Succeeds (generatedOrderId > 0)
        loop For each OrderItem
            ODAO->>DB: psItem.addBatch() (INSERT INTO order_items)
        end
        ODAO->>DB: psItem.executeBatch()
        ODAO->>DB: connection.commit()
        ODAO->>DB: connection.setAutoCommit(true)
        ODAO-->>CheckSvc: return generatedOrderId
        
        CheckSvc->>CartDAO: clearCart(cartId=1)
        CartDAO->>DB: DELETE FROM cart_items WHERE cart_id = 1
        DB-->>CartDAO: Cart cleared
        
        CheckSvc->>CheckSvc: setAttribute("orderId", generatedOrderId)
        CheckSvc->>CheckSvc: setAttribute("totalAmount", totalAmount)
        CheckSvc->>ConfirmView: Forward to /WEB-INF/views/order/order-confirmation.jsp
        ConfirmView-->>User: Render Order Receipt & Success Summary
    else Exception / Failure during Execution
        ODAO->>DB: connection.rollback()
        ODAO->>DB: connection.setAutoCommit(true)
        ODAO-->>CheckSvc: return -1
        CheckSvc->>CheckSvc: setAttribute("errorMessage", "Failed to place order.")
        CheckSvc-->>User: Forward to Checkout View with Error Alert
    end
```

---

## 7. Order History Retrieval Flow

Illustrates retrieving past orders placed by the user alongside detailed line item breakdown.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant HistSvc as OrderHistoryServlet
    participant ODAO as OrderDAOImpl
    participant PDAO as ProductDAOImpl
    participant DB as MySQL Database
    participant View as orders.jsp

    User->>HistSvc: GET /orders (with Session Cookie)
    HistSvc->>HistSvc: Extract userId from Session ("loggedInUser")
    HistSvc->>ODAO: getOrdersByUser(userId)
    ODAO->>DB: SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC
    DB-->>ODAO: ResultSet order rows
    ODAO-->>HistSvc: List<Order>

    loop For each Order
        HistSvc->>ODAO: getOrderItems(order.getOrderId())
        ODAO->>DB: SELECT * FROM order_items WHERE order_id = ?
        DB-->>ODAO: ResultSet order item rows
        ODAO-->>HistSvc: List<OrderItem>
        
        loop For each OrderItem
            HistSvc->>PDAO: getProductById(item.getProductId())
            PDAO->>DB: SELECT * FROM products WHERE product_id = ?
            DB-->>PDAO: Product entity
            PDAO-->>HistSvc: Product entity
            HistSvc->>HistSvc: item.setProduct(product)
        end
        HistSvc->>HistSvc: order.setOrderItems(items)
    end

    HistSvc->>HistSvc: setAttribute("orders", orders)
    HistSvc->>View: Forward to /WEB-INF/views/order/orders.jsp
    View-->>User: Render Order History List HTML
```

---

## 8. User Session Logout Flow

Illustrates invalidating user session state and terminating authentication.

```mermaid
sequenceDiagram
    autonumber
    actor User as User Browser
    participant OutSvc as LogoutServlet
    participant Session as HttpSession

    User->>OutSvc: GET /logout
    OutSvc->>Session: request.getSession(false)
    
    opt Session exists
        OutSvc->>Session: session.invalidate()
        Session-->>OutSvc: Session destroyed
    end

    OutSvc-->>User: HTTP 302 Redirect to /home
```
