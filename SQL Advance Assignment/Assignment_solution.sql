-- SQL Advance Assignment - online shopping platform.

create database sql_Assignment;

use sql_Assignment;

-- Customers table
create table Customers (
	customer_id int primary key,
    customer_name varchar(100) not null,
    city varchar(50),
    email varchar(100) unique not null
);
-- Products table
create table Products (
	product_id int primary key,
    product_name varchar(100) not null,
    category varchar(50) not null,
    price decimal(10,2) not null,
    created_date date not null default (current_date)
);

-- Orders table
create table Orders (
	order_id int primary key,
    customer_id int not null,
    product_id int not null,
    quantity int not null check (quantity>0),
    order_date date not null,
    foreign key(customer_id) references Customers(customer_id),
    foreign key(product_id) references Products(product_id)
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- At least 10 customers
insert into Customers (customer_id, customer_name, city, email)
values (1, 'Aarav Sharma', 'Pune', 'aarav.sharma@example.com'),
	(2, 'Priya Patel', 'Mumbai', 'priya.patel@example.com'),
	(3, 'Rohan Verma', 'Bengaluru', 'rohan.verma@example.com'),
	(4, 'Sneha Nair', 'Chennai', 'sneha.nair@example.com'),
	(5, 'Vikram Joshi', 'Delhi', 'vikram.joshi@example.com'),
	(6, 'Ananya Kulkarni', 'Pune', 'ananya.kulkarni@example.com'),
	(7, 'Siddharth Rao', 'Hyderabad', 'siddharth.rao@example.com'),
	(8, 'Meera Deshmukh', 'Mumbai', 'meera.deshmukh@example.com'),
	(9, 'Kabir Malhotra', 'Delhi', 'kabir.malhotra@example.com'),
	(10, 'Neha Gupta', 'Kolkata', 'neha.gupta@example.com'),
	(11, 'Aditya Roy', 'Bengaluru', 'aditya.roy@example.com'),    
	(12, 'Kavita Iyer', 'Chennai', 'kavita.iyer@example.com'); 

-- At least 10 products
insert into Products (product_id, product_name, category, price, created_date)
values (101, 'Wireless Noise-Canceling Headphones', 'Electronics', 4500.00, '2024-02-15'),
	(102, 'Mechanical Gaming Keyboard', 'Electronics', 3200.00, '2024-05-10'),
	(103, 'USB-C Fast Charger', 'Electronics', 850.00, '2023-11-20'),
	(104, '4K Ultra HD Monitor', 'Electronics', 18500.00, '2024-08-01'),
	(105, 'Ergonomic Office Chair', 'Furniture', 7500.00, '2024-01-12'),
	(106, 'Wooden Study Desk', 'Furniture', 12000.00, '2023-09-05'),
	(107, 'LED Desk Lamp', 'Furniture', 950.00, '2024-06-18'),
	(108, 'Cotton Casual Shirt', 'Apparel', 1250.00, '2024-03-22'),
	(109, 'Running Shoes', 'Apparel', 2800.00, '2024-07-14'),
	(110, 'Denim Jeans', 'Apparel', 1800.00, '2023-12-10'),
	(111, 'Database Internals Book', 'Books', 1450.00, '2024-04-09'),
	(112, 'Clean Code Paperback', 'Books', 799.00, '2024-09-25');
		
-- At least 20 orders
insert into Orders (order_id, customer_id, product_id, quantity, order_date)
values (1001, 1, 101, 1, '2024-10-01'),
	(1002, 1, 103, 2, '2024-10-03'),
	(1003, 1, 111, 1, '2024-10-15'),
	(1004, 2, 104, 1, '2024-10-02'),
	(1005, 2, 105, 1, '2024-10-05'),
	(1006, 3, 102, 1, '2024-10-04'),
	(1007, 3, 109, 2, '2024-10-08'),
	(1008, 4, 106, 1, '2024-10-06'),
	(1009, 4, 107, 2, '2024-10-09'),
	(1010, 5, 108, 3, '2024-10-07'),
	(1011, 5, 110, 2, '2024-10-11'),
	(1012, 6, 101, 1, '2024-10-10'),
	(1013, 6, 112, 2, '2024-10-12'),
	(1014, 7, 104, 1, '2024-10-13'),
	(1015, 7, 102, 1, '2024-10-14'),
	(1016, 8, 109, 1, '2024-10-16'),
	(1017, 8, 108, 2, '2024-10-18'),
	(1018, 9, 105, 2, '2024-10-19'),
	(1019, 9, 103, 1, '2024-10-20'),
	(1020, 10, 111, 2, '2024-10-21'),
	(1021, 10, 112, 1, '2024-10-22'),
	(1022, 2, 101, 1, '2024-10-25');
    
-- ============================================================
-- Section 1: Advanced Joins
-- ============================================================

-- Task 1: Display each customer along with the products they ordered.
select c.customer_id, c.customer_name, p.product_name, p.price, o.quantity, o.order_date
from Customers c 
inner join Orders o on c.customer_id = o.customer_id
inner join Products p on o.product_id = p.product_id
order by c.customer_id, o.order_date;

-- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
select c.customer_id, c.customer_name, p.product_id, p.product_name, p.price
from Customers c
cross join Products p
order by c.customer_id,p.product_id;

-- Task 3: Display all customers and their orders, including customers who have not placed any orders.
select c.customer_id, c.customer_name, c.city, o.order_id, o.product_id, o.quantity, o.order_date
from Customers c
left join Orders o on c.customer_id = o.customer_id
order by c.customer_id, o.order_id;

-- ============================================================
-- Section 2: Subqueries
-- ============================================================

-- Task 4: Find products priced above the average product price.
select product_id, product_name, category, price
from Products 
where price > (select avg(price) from Products);

-- Task 5: Display customers whose total purchase amount is greater than the average customer purchase amount.
select c.customer_id, c.customer_name, coalesce(sum(o.quantity * p.price), 0) as total_purchase_amount
from Customers c
left join Orders o on c.customer_id = o.customer_id
left join Products p on o.product_id = p.product_id
group by c.customer_id, c.customer_name
having coalesce(sum(o.quantity * p.price), 0) > (
    select avg(customer_total)
    from (
        select coalesce(sum(o2.quantity * p2.price), 0) as customer_total
        from Customers c2
        left join Orders o2 on c2.customer_id = o2.customer_id
        left join Products p2 on o2.product_id = p2.product_id
        group by c2.customer_id
    ) as customer_spending
)
order by total_purchase_amount desc;

-- Task 6: Find the highest-priced product in each category using a correlated subquery.
select p1.product_id, p1.product_name, p1.category, p1.price
from Products p1
where p1.price = (
    select MAX(p2.price)
    from Products p2
    where p2.category = p1.category
)
order by p1.category;

-- ============================================================
-- Section 3: Set Operations
-- ============================================================

-- Task 7: Combine products from two different categories using UNION.
select product_id, product_name, category, price
from Products
where category = 'Electronics'
union
select product_id, product_name, category, price
from Products
where category = 'Furniture';

-- Task 8: Write MySQL alternatives for INTERSECT and EXCEPT using INNER JOIN and LEFT JOIN.
-- 8a. INTERSECT Alternative: Customers who ordered BOTH 'Electronics' AND 'Books'
select distinct c.customer_id, c.customer_name
from Customers c
inner join Orders o1 on c.customer_id = o1.customer_id
inner join Products p1 on o1.product_id = p1.product_id and p1.category = 'Electronics'
inner join Orders o2 on c.customer_id = o2.customer_id
inner join Products p2 on o2.product_id = p2.product_id and p2.category = 'Books';

-- 8b. EXCEPT Alternative: Customers who ordered 'Electronics' EXCEPT those who ordered 'Books'
select distinct c.customer_id, c.customer_name
from Customers c
inner join Orders o1 on c.customer_id = o1.customer_id
inner join Products p1 on o1.product_id = p1.product_id and p1.category = 'Electronics'
left join (
    select distinct o2.customer_id
    from Orders o2
    inner join Products p2 on o2.product_id = p2.product_id
    where p2.category = 'Books'
) as book_buyers on c.customer_id = book_buyers.customer_id
where book_buyers.customer_id is null;

-- ============================================================
-- Section 4: Window Functions
-- ============================================================

-- Task 9: Rank products by price within each category.
select product_id, product_name, category, price,
    rank() over (partition by category order by price desc) as price_rank
from Products
order by category, price_rank;

-- Task 10: Display the previous product price (LAG) and a running total of product prices using window functions.
select product_id, product_name, category, price, 
lag(price) over (order by product_id) as previous_product_price, 
SUM(price) over (order by product_id ) as running_total_price
from Products
order by product_id;

-- ============================================================
-- Section 5: Common Table Expressions (CTEs)
-- ============================================================

-- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
with CustomerPurchaseTotals as (
    select c.customer_id, c.customer_name, coalesce(sum(o.quantity * p.price), 0) as total_purchase_amount
    from Customers c
    left join Orders o on c.customer_id = o.customer_id
    left join Products p on o.product_id = p.product_id
    group by c.customer_id, c.customer_name
),
AverageCustomerPurchase as (
    select avg(total_purchase_amount) as average_purchase_amount
    from CustomerPurchaseTotals
)
select cpt.customer_id, cpt.customer_name, cpt.total_purchase_amount
from CustomerPurchaseTotals cpt
cross join AverageCustomerPurchase acp
where cpt.total_purchase_amount > acp.average_purchase_amount
order by cpt.total_purchase_amount desc;

-- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
with recursive NumberSequence as (
    select 1 as number
    union all
    select number + 1
    from NumberSequence
    where number < 10
)
select number
from NumberSequence;

-- ============================================================
-- Section 6: Views
-- ============================================================

-- Task 13: Create a view that displays products priced above ₹1,000 and retrieve data from the view.
create view ProductsAbove1000 as
select product_id, product_name, category, price
from Products
where price > 1000;

select product_id, product_name, category, price
from ProductsAbove1000
order by price desc;

-- ============================================================
-- Section 7: Indexes and Query Performance
-- ============================================================

-- Task 14: Create an index on the category column of the Products table.
create index idx_products_category on Products(category);

-- Task 15: Use EXPLAIN to analyze a query that filters products by category.
explain
select product_id, product_name, category, price
from Products
where category = 'Electronics';

-- ============================================================
-- Section 8: Stored Procedures and Functions
-- ============================================================

-- Task 16: Create a stored procedure to retrieve products by category.
delimiter $$

create procedure GetProductsByCategory(in category_name varchar(50))
begin
    select product_id, product_name, category, price
    from Products
    where category = category_name;
end$$

delimiter ;

-- Task 17: Create a function to calculate the total price of an order (price × quantity).
delimiter $$

create function CalculateOrderTotal(product_id_to_use int, order_quantity int)
returns decimal(12,2)
deterministic
begin
    declare order_total decimal(12,2);

    select price * order_quantity
    into order_total
    from Products
    where product_id = product_id_to_use;

    return coalesce(order_total, 0);
end$$

delimiter ;

-- Demonstration of the stored procedure
call GetProductsByCategory('Electronics');

-- Demonstration of the function
select CalculateOrderTotal(101, 2);

-- ============================================================
-- Section 9: Transactions
-- ============================================================

-- Task 18: Write a transaction that updates a product's price and demonstrate COMMIT and ROLLBACK.
start transaction;

update Products
set price = 4700.00
where product_id = 101;

-- Commit the update.
commit;

start transaction;

update Products
set price = 99999.00
where product_id = 101;

-- Roll back the update so the price remains unchanged by this transaction.
rollback;

-- ============================================================
-- Section 10: SQL Triggers
-- ============================================================

-- Task 19: Create a trigger that automatically records new orders in an Order_Audit table.
create table Order_Audit (
    audit_id int primary key auto_increment,
    order_id int not null,
    customer_id int not null,
    product_id int not null,
    quantity int not null,
    order_date date not null,
    audit_date timestamp default current_timestamp
);

delimiter $$

create trigger trg_orders_after_insert
after insert on Orders
for each row
begin
    insert into Order_Audit (
        order_id,
        customer_id,
        product_id,
        quantity,
        order_date
    )
    values (
        new.order_id,
        new.customer_id,
        new.product_id,
        new.quantity,
        new.order_date
    );
end$$

delimiter ;

-- Demonstration: insert a new order and verify the audit record.
insert into Orders (order_id, customer_id, product_id, quantity, order_date)
values (1023, 11, 110, 1, '2024-10-26');

select audit_id, order_id, customer_id, product_id, quantity, order_date, audit_date
from Order_Audit
order by audit_id desc;

-- ============================================================
-- Section 11: Performance Tuning
-- ============================================================

-- Task 20: Optimize the query by avoiding SELECT *, unnecessary DISTINCT, and functions on indexed columns.
create index idx_products_category_created on Products (category, created_date);

-- Optimized Query:
-- 1. Avoid SELECT * (specify required columns only)
-- 2. Remove unnecessary DISTINCT (product_id is already primary key / unique)
-- 3. Avoid functions on indexed columns (replace YEAR(created_date) = 2024 with range predicate)
-- 4. Index-friendly predicate order matching composite index
select product_id, product_name, category, price, created_date
from Products
where category = 'Electronics'
  and created_date >= '2024-01-01'
  and created_date < '2025-01-01';

