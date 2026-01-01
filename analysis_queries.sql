-- 1 Total Sales per Customer

SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 2 Customers with No Orders (Inactive)

SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 3 Top-Selling Products

SELECT p.product_name,
       SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 4 Customers Spending More Than Average

SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(amount) FROM orders
);

-- 5 Rank Customers by Spending

SELECT customer_id, total_spent,
DENSE_RANK() OVER (ORDER BY total_spent DESC) AS rank_no
FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
) t;

-- 6 Monthly Sales Trend

SELECT MONTH(order_date) AS month,
       SUM(amount) AS total_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;
