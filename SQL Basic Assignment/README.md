# SQL Basics Assignment – Online BookStore

## Assignment Overview

This assignment demonstrates basic SQL concepts using an Online BookStore database.

The SQL script creates an `Authors` table and a `Books` table, populates them with sample data, and includes queries covering basic queries, filtering, sorting, aggregate functions, `GROUP BY` and `HAVING`, joins, data manipulation, and table constraints.

## Database Schema

### Authors

| Column | Data Type | Constraints |
|---|---|---|
| `author_id` | `INT` | Primary key |
| `author_name` | `VARCHAR(100)` | Not null |
| `country` | `VARCHAR(50)` |  |

### Books

| Column | Data Type | Constraints |
|---|---|---|
| `book_id` | `INT` | Primary key |
| `title` | `VARCHAR(100)` | Not null |
| `author_id` | `INT` | Not null, foreign key referencing `Authors(author_id)` |
| `category` | `VARCHAR(50)` |  |
| `price` | `DECIMAL(10,2)` | Not null |
| `published_year` | `INT` |  |

### Publishers

| Column | Data Type | Constraints |
|---|---|---|
| `publisher_id` | `INT` | Primary key |
| `publisher_name` | `VARCHAR(100)` | Not null, unique |
| `country` | `VARCHAR(50)` | Not null, default `India` |
| `established_year` | `INT` | Not null, default `2026` |

## Steps to Execute the SQL Script

1. Open MySQL Workbench or any compatible SQL client.
2. Open `SQL_Basic_Assignment.sql`.
3. Execute the complete script from top to bottom.
4. Verify the database and tables in the SQL client.
5. Run each section's queries and verify the output.

The script creates the `sql_Assignment` database, selects it with `USE`, creates and populates the required tables, and then executes all assignment tasks in order.


