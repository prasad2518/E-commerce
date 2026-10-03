# Controller to DAO Call Mappings & Specifications

This document outlines the operational mapping between **Controller Servlets** and **Data Access Objects (DAOs)** in the **FashionStore** web application. It specifies HTTP endpoint routes, request parameters, session interactions, DAO method invocations, and target JSP rendering paths.

---

## 📊 Master Controller-to-DAO Call Matrix

| Servlet Class (`com.fashionstore.controller`) | URL Pattern (`@WebServlet`) | HTTP Method | Request Inputs / Parameters | Injected DAO Dependencies | DAO Methods Invoked | Session Actions / Set Attributes | Target View / Forward / Redirect |
|---|---|---|---|---|---|---|---|
| **`LoginServlet`** | `/login` | `GET` | None | `UserDAO` (`UserDAOImpl`) | None | None | Forward: `/WEB-INF/views/auth/login.jsp` |
| | | `POST` | `email`, `password` | `UserDAO` (`UserDAOImpl`) | `loginUser(email, password)` | `session.setAttribute("loggedInUser", user)` | Redirect: `/home` (on success)<br>Forward: `/WEB-INF/views/auth/login.jsp` (on failure) |
| **`RegisterServlet`** | `/register` | `GET` | None | `UserDAO` (`UserDAOImpl`) | None | None | Forward: `/WEB-INF/views/auth/register.jsp` |
| | | `POST` | `name`, `email`, `phone`, `address`, `password` | `UserDAO` (`UserDAOImpl`) | `registerUser(user)` | None | Redirect: `/login` (on success)<br>Forward: `/WEB-INF/views/auth/register.jsp` (on failure) |
| **`LogoutServlet`** | `/logout` | `GET` | None | None | None | `session.invalidate()` | Redirect: `/home` |
| **`HomeServlet`** | `/home` | `GET` | None | `ProductDAO` (`ProductDAOImpl`) | `getAllProducts()` | `request.setAttribute("products", list)` | Forward: `/WEB-INF/views/home/home.jsp` |
| **`ProductsServlet`** | `/products` | `GET` | `categoryId` (optional), `sort` (optional: `low_high`, `high_low`) | `ProductDAO` (`ProductDAOImpl`), `CategoryDAO` (`CategoryDAOImpl`) | `getProductsByCategory(catId)` or `getAllProducts()`, `getAllCategories()` | `request.setAttribute("products", list)`, `request.setAttribute("categories", list)` | Forward: `/WEB-INF/views/product/products.jsp` |
| **`ProductServlet`** | `/product` | `GET` | `id` | `ProductDAO` (`ProductDAOImpl`) | `getProductById(id)` | `request.setAttribute("product", product)` | Forward: `/WEB-INF/views/product/product.jsp` |
| **`CategoryServlet`** | `/category` | `GET` | `id` | `ProductDAO` (`ProductDAOImpl`), `CategoryDAO` (`CategoryDAOImpl`) | `getProductsByCategory(id)`, `getCategoryById(id)` | `request.setAttribute("products", list)`, `request.setAttribute("category", category)` | Forward: `/WEB-INF/views/category/category.jsp` |
| **`SearchServlet`** | `/search` | `GET` | `keyword` | `ProductDAO` (`ProductDAOImpl`) | `searchProducts(keyword)` | `request.setAttribute("products", list)`, `request.setAttribute("keyword", keyword)` | Forward: `/WEB-INF/views/search/search.jsp` |
| **`CartServlet`** | `/cart` | `GET` | Hardcoded `cartId = 1` | `CartDAO` (`CartDAOImpl`), `ProductDAO` (`ProductDAOImpl`) | `getCartItems(cartId)`, `getProductById(productId)` | `request.setAttribute("cartItems", cartItems)` | Forward: `/WEB-INF/views/cart/cart.jsp` |
| | | `POST` | `cartId`, `productId`, `quantity` | `CartDAO` (`CartDAOImpl`) | `addToCart(cartItem)` | None | Redirect: `/cart` (on success)<br>Redirect: `/product?id=X` (on failure) |
| **`RemoveCartItemServlet`** | `/remove-cart-item` | `GET` | `id` (cartItemId) | `CartDAO` (`CartDAOImpl`) | `removeCartItem(cartItemId)` | None | Redirect: `/cart` |
| **`CheckoutServlet`** | `/checkout` | `GET` | Hardcoded `cartId = 1` | `CartDAO` (`CartDAOImpl`), `ProductDAO` (`ProductDAOImpl`) | `getCartItems(cartId)`, `getProductById(productId)` | `request.setAttribute("cartItems", list)`, `request.setAttribute("totalAmount", total)` | Forward: `/WEB-INF/views/order/checkout.jsp` |
| | | `POST` | `fullName`, `address`, `phone`, `paymentMethod` | `CartDAO` (`CartDAOImpl`), `OrderDAO` (`OrderDAOImpl`), `ProductDAO` (`ProductDAOImpl`) | `getCartItems(1)`, `getProductById(...)`, `createOrder(order, items)`, `clearCart(1)` | `session.getAttribute("loggedInUser")`, `request.setAttribute("orderId", id)` | Forward: `/WEB-INF/views/order/order-confirmation.jsp` (success)<br>Forward: `doGet()` (failure) |
| **`OrderHistoryServlet`** | `/orders` | `GET` | None | `OrderDAO` (`OrderDAOImpl`), `ProductDAO` (`ProductDAOImpl`) | `getOrdersByUser(userId)`, `getOrderItems(orderId)`, `getProductById(productId)` | `session.getAttribute("loggedInUser")`, `request.setAttribute("orders", list)` | Forward: `/WEB-INF/views/order/orders.jsp` |
| **`AboutServlet`** | `/about` | `GET` | None | None | None | None | Forward: `/WEB-INF/views/common/about.jsp` |
| **`ContactServlet`** | `/contact` | `GET` | None | None | None | None | Forward: `/WEB-INF/views/common/contact.jsp` |

---

## 🔍 Detailed Controller Specifications

### 1. Authentication Controllers

#### `LoginServlet` (`/login`)
- **Initialization**: Instantiates `UserDAO userDAO = new UserDAOImpl()`.
- **`doGet`**: Forwards directly to `/WEB-INF/views/auth/login.jsp`.
- **`doPost`**:
  1. Extracts `email` and `password` parameters.
  2. Invokes `userDAO.loginUser(email, password)`.
  3. If user is found, stores object in HTTP Session under key `"loggedInUser"` and redirects to `/home`.
  4. If user is null, sets `"errorMessage"` request attribute and forwards back to `login.jsp`.

#### `RegisterServlet` (`/register`)
- **Initialization**: Instantiates `UserDAO userDAO = new UserDAOImpl()`.
- **`doGet`**: Forwards directly to `/WEB-INF/views/auth/register.jsp`.
- **`doPost`**:
  1. Constructs a new `User` entity from parameters (`name`, `email`, `phone`, `address`, `password`).
  2. Calls `userDAO.registerUser(user)`.
  3. On success, redirects to `/login`.
  4. On failure, sets `"errorMessage"` attribute and forwards back to `register.jsp`.

#### `LogoutServlet` (`/logout`)
- **`doGet`**:
  1. Retrieves active session via `request.getSession(false)`.
  2. Invalidates session if present (`session.invalidate()`).
  3. Redirects browser to context root `/home`.

---

### 2. Catalog & Discovery Controllers

#### `HomeServlet` (`/home`)
- **Initialization**: Instantiates `productDAO = new ProductDAOImpl()` in `init()`.
- **`doGet`**:
  1. Calls `productDAO.getAllProducts()`.
  2. Attaches resulting `List<Product>` to request as `"products"`.
  3. Forwards to `/WEB-INF/views/home/home.jsp`.

#### `ProductsServlet` (`/products`)
- **Initialization**: Instantiates `ProductDAO` and `CategoryDAO`.
- **`doGet`**:
  1. Parses optional `categoryId` parameter. If present, calls `productDAO.getProductsByCategory(catId)`. Otherwise calls `productDAO.getAllProducts()`.
  2. Parses optional `sort` parameter (`low_high` or `high_low`). Uses Java Streams `.sorted()` to sort products dynamically in memory.
  3. Calls `categoryDAO.getAllCategories()` to populate side filter menus.
  4. Attaches `"categories"`, `"products"`, `"selectedCategoryId"`, and `"selectedSort"` attributes.
  5. Forwards to `/WEB-INF/views/product/products.jsp`.

#### `ProductServlet` (`/product`)
- **Initialization**: Instantiates `productDAO = new ProductDAOImpl()`.
- **`doGet`**:
  1. Reads integer `id` from query parameter (`/product?id=101`).
  2. Fetches product details via `productDAO.getProductById(productId)`.
  3. Sets `"product"` request attribute and forwards to `/WEB-INF/views/product/product.jsp`.

#### `CategoryServlet` (`/category`)
- **Initialization**: Instantiates `productDAO` and `categoryDAO`.
- **`doGet`**:
  1. Reads `id` parameter (`/category?id=2`).
  2. Calls `productDAO.getProductsByCategory(categoryId)` and `categoryDAO.getCategoryById(categoryId)`.
  3. Sets `"products"`, `"category"`, and `"categoryId"` attributes.
  4. Forwards to `/WEB-INF/views/category/category.jsp`.

#### `SearchServlet` (`/search`)
- **Initialization**: Instantiates `productDAO = new ProductDAOImpl()`.
- **`doGet`**:
  1. Extracts `keyword` parameter (`/search?keyword=shirt`).
  2. Invokes `productDAO.searchProducts(keyword)`.
  3. Attaches `"products"` list and `"keyword"` string to request.
  4. Forwards to `/WEB-INF/views/search/search.jsp`.

---

### 3. Shopping Cart & Order Controllers

#### `CartServlet` (`/cart`)
- **Initialization**: Instantiates `CartDAO` and `ProductDAO`.
- **`doGet`**:
  1. Loads cart items using `cartDAO.getCartItems(1)`.
  2. Iterates over cart items and calls `productDAO.getProductById(item.getProductId())` to populate nested `Product` reference.
  3. Attaches `"cartItems"` to request and forwards to `/WEB-INF/views/cart/cart.jsp`.
- **`doPost`**:
  1. Reads `cartId`, `productId`, and `quantity` form data.
  2. Constructs `CartItem` object and calls `cartDAO.addToCart(cartItem)`.
  3. Redirects to `/cart` on success or `/product?id=X` on failure.

#### `RemoveCartItemServlet` (`/remove-cart-item`)
- **`doGet`**:
  1. Reads integer parameter `id` (`/remove-cart-item?id=5`).
  2. Executes `cartDAO.removeCartItem(cartItemId)`.
  3. Redirects back to `/cart`.

#### `CheckoutServlet` (`/checkout`)
- **Initialization**: Instantiates `CartDAO`, `OrderDAO`, and `ProductDAO`.
- **`doGet`**:
  1. Fetches current cart items (`cartDAO.getCartItems(1)`).
  2. Enriches each item with `Product` object and calculates total order amount.
  3. Sets `"cartItems"` and `"totalAmount"` attributes and forwards to `/WEB-INF/views/order/checkout.jsp`.
- **`doPost`**:
  1. Extracts user from session (`request.getSession().getAttribute("loggedInUser")`). Defaults `userId = 1` if guest.
  2. Reads shipping info (`fullName`, `address`, `phone`, `paymentMethod`).
  3. Converts active `CartItem`s into `OrderItem` instances and computes grand total.
  4. Instantiates `Order` entity.
  5. Executes transactional placement via `orderDAO.createOrder(order, orderItems)`.
  6. Upon receiving valid generated `orderId`:
     - Clears user cart via `cartDAO.clearCart(1)`.
     - Sets `"orderId"` and `"totalAmount"` attributes.
     - Forwards to `/WEB-INF/views/order/order-confirmation.jsp`.

#### `OrderHistoryServlet` (`/orders`)
- **Initialization**: Instantiates `OrderDAO` and `ProductDAO`.
- **`doGet`**:
  1. Resolves logged-in user ID from session.
  2. Invokes `orderDAO.getOrdersByUser(userId)`.
  3. For every order returned, retrieves line items via `orderDAO.getOrderItems(order.getOrderId())` and populates product details.
  4. Attaches `"orders"` list and forwards to `/WEB-INF/views/order/orders.jsp`.
