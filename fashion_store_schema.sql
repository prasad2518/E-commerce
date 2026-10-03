-- ============================================================
-- FashionStore Complete Database Schema & Seed Data Script
-- ============================================================

CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(150) NOT NULL,
    brand VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT,
    payment_method VARCHAR(50),
    order_status VARCHAR(50) DEFAULT 'Placed',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================================
-- SEED DATA
-- ============================================================

INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Men''s Wear', 'Stylish men''s t-shirts, shirts, jeans, and hoodies'),
(2, 'Women''s Collection', 'Trendy dresses, tops, kurtis, and denim'),
(3, 'Kids Wear', 'Cute and comfortable clothing for boys and girls'),
(4, 'Footwear', 'Casual sneakers, formal shoes, and sandals'),
(5, 'Accessories', 'Leather belts, wallets, caps, and backpacks'),
(6, 'Watches', 'Luxury analog and smartwatches for men and women')
ON DUPLICATE KEY UPDATE category_name=VALUES(category_name);

INSERT INTO users (user_id, full_name, email, phone, address, password) VALUES
(1, 'Demo User', 'user@example.com', '9876543210', '123 Main Street, Tech City', '12345')
ON DUPLICATE KEY UPDATE email=VALUES(email);

INSERT INTO cart (cart_id, user_id) VALUES
(1, 1)
ON DUPLICATE KEY UPDATE user_id=VALUES(user_id);

INSERT INTO products (product_id, category_id, product_name, brand, description, price, image_url) VALUES
(1, 1, 'Classic Cotton T-Shirt', 'Nike', 'Premium 100% breathable cotton crew neck t-shirt for daily wear.', 799.00, 'classic_cotton_tshirt.jpg'),
(2, 1, 'Slim Fit Denim Jeans', 'Levi''s', 'Stretchable slim fit blue denim jeans with classic 5-pocket styling.', 1999.00, 'slim_fit_jeans.jpg'),
(3, 1, 'Hooded Sweatshirt', 'Puma', 'Warm fleece pullover hoodie with kangaroo pocket and adjustable drawstring.', 2499.00, 'hooded_sweatshirt.jpg'),
(4, 1, 'Formal White Shirt', 'Arrow', 'Crisp cotton formal button-up shirt suitable for business meetings.', 1499.00, 'formal_white_shirt.jpg'),
(5, 1, 'Checked Casual Shirt', 'Roadster', '100% cotton casual plaid shirt with button-down collar.', 1299.00, 'checked_shirt.jpg'),
(6, 2, 'Floral Maxi Dress', 'Zara', 'Elegant A-line floral print maxi dress with ruffle sleeves.', 2999.00, 'floral_maxi_dress.jpg'),
(7, 2, 'Women Cotton Kurti', 'Biba', 'Traditional printed ethnic kurti with intricate neck design.', 1199.00, 'women_kurti.jpg'),
(8, 2, 'High Waist Skinny Jeans', 'H&M', 'Stretch denim high-waisted skinny jeans for sleek modern look.', 1799.00, 'high_waist_jeans.jpg'),
(9, 2, 'Casual Crop Top', 'Forever 21', 'Ribbed cotton short sleeve crop top for summer fashion.', 699.00, 'crop_top.jpg'),
(10, 2, 'Designer Party Gown', 'Manish Malhotra', 'Premium embroidered evening gown for celebrations and receptions.', 5999.00, 'party_gown.jpg'),
(11, 3, 'Kids Printed T-Shirt', 'Max', 'Soft organic cotton t-shirt with playful cartoon graphic.', 499.00, 'kids_printed_tshirt.jpg'),
(12, 3, 'Boys Casual Shirt', 'Allen Solly Junior', 'Lightweight cotton short-sleeve shirt for young boys.', 899.00, 'boys_casual_shirt.jpg'),
(13, 3, 'Girls Floral Frock', 'Mothercare', 'Cute knee-length cotton frock with bow belt detail.', 1099.00, 'girls_frock.jpg'),
(14, 3, 'Kids Denim Shorts', 'US Polo', 'Durable denim shorts with elasticized waist for active kids.', 799.00, 'kids_denim_shorts.jpg'),
(15, 3, 'Kids Hooded Jacket', 'Gap Kids', 'Cozy fleece zip-up hoodie jacket.', 1399.00, 'kids_hoodie.jpg'),
(16, 4, 'Casual Running Sneakers', 'Adidas', 'Lightweight cushioned running shoes with mesh upper.', 3499.00, 'casual_sneakers.jpg'),
(17, 4, 'Formal Leather Shoes', 'Bata', 'Genuine polished leather derby formal shoes.', 2499.00, 'formal_shoes.jpg'),
(18, 4, 'Beach Flip Flops', 'Puma', 'Waterproof anti-slip rubber flip flop slippers.', 599.00, 'flip_flops.jpg'),
(19, 4, 'Sports Outdoor Sandals', 'Woodland', 'Rugged outdoor sandals with adjustable velcro straps.', 2199.00, 'sports_sandals.jpg'),
(20, 5, 'Genuine Leather Belt', 'Tommy Hilfiger', 'Classic brown genuine leather belt with metallic pin buckle.', 999.00, 'leather_belt.jpg'),
(21, 5, 'Travel Laptop Backpack', 'Wildcraft', 'Water-resistant 30L laptop backpack with padded shoulder straps.', 1899.00, 'travel_backpack.jpg'),
(22, 5, 'Men Leather Wallet', 'Fossil', 'Bi-fold RFID blocking genuine leather wallet with coin pocket.', 1299.00, 'wallet.jpg'),
(23, 5, 'Cotton Baseball Cap', 'Puma', 'Adjustable unisex cotton curved visor baseball cap.', 499.00, 'baseball_cap.jpg'),
(24, 6, 'Analog Stainless Steel Watch', 'Titan', 'Classic silver stainless steel analog watch with date display.', 3999.00, 'titan_watch.jpg'),
(25, 6, 'Leather Strap Watch', 'Fossil', 'Chronograph brown leather strap quartz watch.', 6499.00, 'fossil_watch.jpg'),
(26, 6, 'Casual Digital Watch', 'Sonata', 'Water-resistant digital sports watch with backlight.', 1199.00, 'sonata_watch.jpg'),
(27, 6, 'Vintage Gold Watch', 'Casio', 'Iconic retro gold digital watch.', 2999.00, 'casio_watch.jpg'),
(28, 6, 'Bluetooth Smartwatch', 'Noise', 'HD touch display smartwatch with heart rate & SpO2 monitor.', 2199.00, 'noise_smartwatch.jpg')
ON DUPLICATE KEY UPDATE product_name=VALUES(product_name);
