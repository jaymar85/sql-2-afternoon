-- *** Create 3 tables following the criteria in the summary. ***

-- users
CREATE TABLE users 
( user_id SERIAL PRIMARY KEY, name VARCHAR(50), email VARCHAR(200) );

-- products
CREATE TABLE products 
( product_id SERIAL PRIMARY KEY, name VARCHAR(50), price INTEGER );

-- orders
CREATE TABLE orders ( 
	order_id SERIAL PRIMARY KEY,  
    user_id INTEGER REFERENCES users(user_id),
    product_id INTEGER REFERENCES products(product_id)
);
-- *** Add some data to fill up each table. ***

--  users need a name and an email.
INSERT INTO users ( 
  name, email 
) VALUES 
( 'Theo', 'theodunking@lordofdarings.cl' ),
( 'Christina', 'yostina1@fancythat.cl' ),
( 'Lucy', 'wutupyo@sup.cl' );

-- products products need a name and a price
INSERT INTO products ( 
  name, price 
) VALUES 
( 'frog', 13 ),
( 'coffee', 11 ),
( 'bird', 5 );

-- orders need a ref to product.
-- I am referencing products to orders and then adding users later.
INSERT INTO orders (
    product_id  
)   VALUES 
(1),
(2),
(3);

-- *** Run queries against your data ***

-- Get all products for the first order.
SELECT * FROM orders WHERE order_id = 1;

-- Get all orders.
SELECT * FROM orders;

-- Get the total cost of an order (sum the price of all products on an order)
SELECT o.order_id SUM(p.price) 
FROM products p
INNER JOIN orders o 
ON p.product_id = o.product_id
WHERE o.order_id = 1
GROUP BY o.order_id;

-- *** Add a foreign key reference from orders to users. ***
ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(order_id);
SELECT * FROM users

-- *** Update the orders table to link a user to each order. ***
UPDATE users
SET order_id = 1
WHERE user_id = 1;

UPDATE users
SET order_id = 2
WHERE user_id = 2;

UPDATE users
SET order_id = 3
WHERE user_id = 3;

-- *** Run queries against your data ***
-- Get all orders for a user.
SELECT * FROM users u
INNER JOIN orders o
ON o.order_id = u.order_id
WHERE u.user_id = 1;

-- Get how many orders each user has.
SELECT COUNT(*) FROM users u
INNER JOIN orders o
ON o.order_id = u.order_id
WHERE u.user_id = 1;