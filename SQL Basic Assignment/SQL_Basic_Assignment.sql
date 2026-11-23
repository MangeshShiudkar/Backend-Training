-- SQL Basics Assignment - Online BookStore

create database sql_Assignment;

use sql_Assignment;

-- Authors table
create table Authors(
	author_id int primary key,
    author_name varchar(100) not null,
    country varchar(50)
);

-- Books table
create table Books(
	book_id int primary key,
    title varchar(100) not null,
    author_id int not null,
    category varchar(50),
    price decimal(10,2) not null,
    published_year int,
    foreign key (author_id) references Authors(author_id)
);

-- ============================================================
-- SAMPLE DATA
-- At least 5 authors from different countries.
-- ============================================================

insert into Authors (author_id, author_name, country)
values (1, 'Robert C. Martin', 'United States'),
    (2, 'Joshua Bloch', 'United States'),
    (3, 'R. K. Narayan', 'India'),
    (4, 'J. K. Rowling', 'United Kingdom'),
    (5, 'Paulo Coelho', 'Brazil');
    

-- At least 10 books from different categories.

insert into Books (book_id, title, author_id, category, price, published_year)
values (101, 'Clean Code', 1, 'Programming', 850.00, 2008),
    (102, 'The Clean Coder', 1, 'Programming', 750.00, 2011),
    (103, 'Clean Architecture', 1, 'Programming', 900.00, 2017),
    (104, 'Effective Java', 2, 'Programming', 800.00, 2018),
    (105, 'Java: The Complete Reference', 2, 'Programming', 950.00, 2022),
    (106, 'Malgudi Days', 3, 'Fiction', 450.00, 1943),
    (107, 'The Guide', 3, 'Fiction', 550.00, 1958),
    (108, 'Harry Potter and the Philosopher''s Stone', 4, 'Fantasy', 650.00, 1997),
    (109, 'Harry Potter and the Goblet of Fire', 4, 'Fantasy', 780.00, 2000),
    (110, 'Sapiens', 2, 'History', 720.00, 2021);
    
    
-- ============================================================
-- SECTION 1: BASIC QUERIES
-- ============================================================

-- Task 1: Display all books.
select * 
from Books;

-- Task 2: Display only the book title and price.
select title, price 
from Books;

-- Task 3: Display the book title as Book Name and price as Book Price using column aliases.
select title as 'Book Title', price as 'Book Price' 
from Books;

-- Task 4: Display all unique book categories.
select distinct category 
from Books;

-- ============================================================
-- SECTION 2: FILTERING DATA
-- ============================================================

-- Task 5: Display books priced above ₹700.
select * 
from Books 
where price > 700;

-- Task 6: Display books priced between ₹500 and ₹800.
select * 
from Books 
where price between 500 and 800;

-- Task 7: Display books that belong to the Programming category.
select * 
from Books 
where category = 'Programming';

-- Task 8: Display books whose titles start with the letter S.
select * 
from Books 
where title like 'S%';

-- Task 9: Display books published after 2020.
select * 
from Books 
where published_year > 2020;

-- ============================================================
-- SECTION 3: SORTING AND LIMITING RESULTS
-- ============================================================

-- Task 10: Display books sorted by price in descending order.
select * 
from Books 
Order by price desc;

-- Task 11: Display the top 3 most expensive books.
select * 
from Books 
Order by price desc 
limit 3;

-- ============================================================
-- SECTION 4: AGGREGATE FUNCTIONS
-- ============================================================

-- Task 12: Find: Total number of books, Total price of all books, Average book price, Highest book price, Lowest book price
select count(*) as Total_Books, sum(price) as All_Books_Price, avg(price) as Avg_Book_Price, max(price) as Max_Book_Price, min(price) as Low_Book_Price 
from Books;

-- ============================================================
-- SECTION 5: GROUP BY AND HAVING
-- ============================================================

-- Task 13: Display the average book price for each category.
select category, avg(price) as Average_Book_Price 
from Books 
group by category;

-- Task 14: Display only those categories whose average book price is greater than ₹650.
select category, avg(price) as Average_Book_Price 
from Books 
group by category 
having avg(price) > 650;

-- ============================================================
-- SECTION 6: JOINS
-- ============================================================

-- Task 15: Display each book along with its author's name using an INNER JOIN.
select b.book_id, b.title, a.author_name, b.category, b.price, b.published_year
from Books b
inner join Authors a 
on a.author_id = b.author_id;

-- Task 16: Display all authors along with the books they have written using a LEFT JOIN.
select a.author_id, a.author_name, a.country, b.book_id, b.title
from Authors a
left join Books b
on a.author_id = b.author_id;

-- Task 17: Display all books along with their author details using a RIGHT JOIN.
select  b.book_id, b.title, b.category, b.price, a.author_id, a.author_name, a.country
from Authors a
right join Books b
on a.author_id = b.author_id;

-- ============================================================
-- SECTION 7: DATA MANIPULATION
-- ============================================================

-- Task 18: Insert a new book into the Books table.
insert into Books (book_id, title, author_id, category, price, published_year)
values(111, 'Spring Boot in Practice', 1, 'Programming', 699.00, 2024);

-- Verify task 18
select *
from Books
where book_id = 111;

-- Task 19: Update the price of the book you inserted.
update Books 
set price = 799.00
where book_id = 111;

-- Verify task 19
select *
from Books
where book_id = 111;

-- Task 20: Delete the book record that you inserted.
delete from Books
where book_id = 111;

-- verify task 20
select *
from Books
where book_id = 111;

-- ============================================================
-- SECTION 8: CREATING TABLES AND CONSTRAINTS
-- ============================================================

-- Task 21: Create the Publishers table.
-- Constraints used:
-- PRIMARY KEY: publisher_id uniquely identifies each publisher.
-- NOT NULL: publisher_name and country must have values.
-- UNIQUE: publisher_name cannot be duplicated.
-- DEFAULT: country is set to India when it is not provided.
-- DEFAULT: established_year is set to 2026 when not provided.
create table Publishers (
    publisher_id int primary key,
    publisher_name varchar(100) not null unique,
    country varchar(50) not null default 'India',
    established_year int not null default 2026
);

