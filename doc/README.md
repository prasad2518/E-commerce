# FashionStore Architecture & System Documentation

Welcome to the technical architecture documentation for **FashionStore**, an e-commerce web application developed using the Java Enterprise / Jakarta EE platform with Model-View-Controller (MVC) design pattern, Data Access Objects (DAO), and MySQL relational database persistence.

---

## 📐 Technology Stack

| Layer | Technology |
|---|---|
| **Language & Runtime** | Java 17+ |
| **Web Container / Servlet Engine** | Jakarta EE Servlet API (`jakarta.servlet.*`) |
| **Presentation / View Layer** | JavaServer Pages (JSP), HTML5, CSS3, JavaScript |
| **Controller Layer** | Jakarta Servlets (`@WebServlet`) |
| **Persistence / DAO Layer** | JDBC (`java.sql.*`), MySQL Connector/J |
| **Database Engine** | MySQL (`fashion_store`) |
| **Build & Dependency Management** | Apache Maven (`pom.xml`) |

---

## 📁 Package & Codebase Structure

```
FashionStore/
├── pom.xml                                      # Maven configuration & Jakarta EE dependencies
├── src/main/java/com/fashionstore/
│   ├── controller/                              # Servlet Controllers (HTTP Request Processing)
│   │   ├── AboutServlet.java
│   │   ├── CartServlet.java
│   │   ├── CategoryServlet.java
│   │   ├── CheckoutServlet.java
│   │   ├── ContactServlet.java
│   │   ├── HomeServlet.java
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── OrderHistoryServlet.java
│   │   ├── ProductServlet.java
│   │   ├── ProductsServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── RemoveCartItemServlet.java
│   │   └── SearchServlet.java
│   ├── dao/                                     # DAO Interfaces (Data Access Abstraction)
│   │   ├── CartDAO.java
│   │   ├── CategoryDAO.java
│   │   ├── OrderDAO.java
│   │   ├── ProductDAO.java
│   │   └── UserDAO.java
│   ├── dao/impl/                                # DAO Implementations (JDBC SQL Operations)
│   │   ├── CartDAOImpl.java
│   │   ├── CategoryDAOImpl.java
│   │   ├── OrderDAOImpl.java
│   │   ├── ProductDAOImpl.java
│   │   └── UserDAOImpl.java
│   ├── model/                                   # Domain Entities / POJOs (State Models)
│   │   ├── Cart.java
│   │   ├── CartItem.java
│   │   ├── Category.java
│   │   ├── Order.java
│   │   ├── OrderItem.java
│   │   ├── Product.java
│   │   └── User.java
│   ├── util/                                    # System Utilities & Database Connection Manager
│   │   ├── DBConnection.java
│   │   └── TestDBConnection.java
│   └── test/                                    # Integration & Database Connection Tests
│       └── DBTest.java
└── src/main/webapp/
    ├── WEB-INF/
    │   ├── web.xml                              # Web Application Deployment Descriptor
    │   └── views/                               # Secure Encapsulated View Templates
    │       ├── auth/                            # login.jsp, register.jsp
    │       ├── cart/                            # cart.jsp
    │       ├── category/                        # category.jsp
    │       ├── common/                          # header, navbar, footer, sidebar, about, contact
    │       ├── home/                            # home.jsp
    │       ├── order/                           # checkout.jsp, order-confirmation.jsp, orders.jsp
    │       ├── product/                         # product.jsp, products.jsp
    │       └── search/                          # search.jsp
    └── assets/                                  # Static Web Assets (CSS, JS, Product Images)
```

---

## 📚 Documentation Index

| Documentation Module | Contents |
|---|---|
| 🏛️ **[Architecture & Class Diagrams](file:///c:/FashionStoreWorkspace/FashionStore/doc/architecture.md)** | High-level MVC architecture diagrams, component layers, and complete class diagrams for Models, Controllers, DAOs, and Utilities. |
| 🗄️ **[Database Schemas & Mappings](file:///c:/FashionStoreWorkspace/FashionStore/doc/database.md)** | Entity-Relationship (ER) diagram, table DDL specifications, foreign key constraints, and POJO-to-Table mapping matrix. |
| 🔌 **[Controller-to-DAO Mappings](file:///c:/FashionStoreWorkspace/FashionStore/doc/controllers_and_daos.md)** | Controller endpoint mapping table, HTTP handlers (`doGet`/`doPost`), request parameter resolution, session state management, DAO method execution, and view dispatching. |
| 🔄 **[Sequence Diagrams](file:///c:/FashionStoreWorkspace/FashionStore/doc/sequence_diagrams.md)** | End-to-end Mermaid sequence diagrams for all core user journeys (Auth, Catalog Browsing, Search, Cart Management, Transactional Checkout, Order History, Logout). |
