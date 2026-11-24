# SQL (Advanced) Assignment

## Assignment Overview

This assignment demonstrates advanced SQL concepts using a relational database for an online shopping platform. The solution manages customer, product, and order information and includes reporting, sales analysis, database automation, transactions, triggers, indexing, and performance tuning.

The deliverable is a single SQL script containing table definitions, sample data, solutions for all 20 tasks, and database objects such as views, indexes, stored procedures, functions, and triggers.

## Database Schema

### Customers

- `customer_id`
- `customer_name`
- `city`
- `email`

### Products

- `product_id`
- `product_name`
- `category`
- `price`

### Orders

- `order_id`
- `customer_id`
- `product_id`
- `quantity`
- `order_date`

## Sample Data Requirements

- At least 10 customers
- At least 10 products
- At least 20 orders

## Steps to Execute the SQL Script

1. Open MySQL Workbench or another MySQL client.
2. Connect to the MySQL server.
3. Open `Assignment_solution.sql`.
4. Set the SQL delimiter correctly if required by the client.
5. Execute the complete script from top to bottom.
6. Verify the tables, sample data, views, index, procedure, function, trigger, and query results.

## Implemented Advanced SQL Concepts

### Section 1: Advanced Joins

- Inner joins
- Cross join
- Left join

### Section 2: Subqueries

- Scalar subquery
- Average purchase subquery
- Correlated subquery

### Section 3: Set Operations

- `UNION`
- MySQL alternatives for `INTERSECT` using `INNER JOIN`
- MySQL alternatives for `EXCEPT` using `LEFT JOIN`

### Section 4: Window Functions

- `RANK()`
- `LAG()`
- Running totals using `SUM() OVER (...)`

### Section 5: Common Table Expressions

- Standard CTE
- Recursive CTE

### Section 6: Views

- View containing products priced above ₹1,000

### Section 7: Indexes and Query Performance

- Index on the `Products.category` column
- `EXPLAIN` analysis

### Section 8: Stored Procedures and Functions

- Stored procedure to retrieve products by category
- Function to calculate an order's total price

### Section 9: Transactions

- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`

### Section 10: SQL Triggers

- `AFTER INSERT` trigger
- Automatic order audit recording

### Section 11: Performance Tuning

- Select only required columns
- Avoid unnecessary `DISTINCT`
- Avoid functions on indexed columns
- Use index-friendly predicates
- Use date ranges instead of date functions

## Assignment Tasks

1. Display each customer along with the products they ordered.
2. Display all possible combinations of customers and products using a `CROSS JOIN`.
3. Display all customers and their orders, including customers with no orders.
4. Find products priced above the average product price.
5. Display customers whose total purchase amount is above the average customer purchase amount.
6. Find the highest-priced product in each category using a correlated subquery.
7. Combine products from two categories using `UNION`.
8. Provide MySQL alternatives for `INTERSECT` and `EXCEPT` using joins.
9. Rank products by price within each category.
10. Display the previous product price using `LAG()` and a running product-price total.
11. Create a CTE for customers with above-average purchase totals.
12. Create a recursive CTE to generate numbers from 1 to 10.
13. Create a view for products priced above ₹1,000 and retrieve data from it.
14. Create an index on `Products.category`.
15. Use `EXPLAIN` to analyze a category-filter query.
16. Create a stored procedure to retrieve products by category.
17. Create a function to calculate an order total from price and quantity.
18. Demonstrate `COMMIT` and `ROLLBACK` in a transaction.
19. Create a trigger that records newly inserted orders in `Order_Audit`.
20. Optimize queries using performance-tuning best practices.

