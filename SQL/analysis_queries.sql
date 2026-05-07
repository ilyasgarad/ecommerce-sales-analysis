/* =========================================================
   E-Commerce Sales Analysis - SQL Queries
   Author: Ilyas Abdisalam Ibrahim
   Description:
   This script contains all SQL queries used to analyze
   e-commerce sales data for business insights.
   ========================================================= */


/* =========================
   1. BASIC DATA CHECK
   ========================= */

-- Preview data
SELECT TOP 10 *
FROM sales_data;

-- Total rows
SELECT COUNT(*) AS total_rows
FROM sales_data;


/* =========================
   2. CORE KPIs
   ========================= */

-- Total Revenue
SELECT SUM(Revenue) AS total_revenue
FROM sales_data;

-- Total Orders
SELECT COUNT(DISTINCT Invoice) AS total_orders
FROM sales_data;

-- Total Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM sales_data
WHERE CustomerID IS NOT NULL;

-- Total Quantity Sold
SELECT SUM(Quantity) AS total_quantity
FROM sales_data;

-- Average Order Value
SELECT 
    SUM(Revenue) / COUNT(DISTINCT Invoice) AS avg_order_value
FROM sales_data;


/* =========================
   3. TIME ANALYSIS
   ========================= */

-- Monthly Revenue Trend
SELECT 
    Year,
    Month,
    SUM(Revenue) AS monthly_revenue
FROM sales_data
GROUP BY Year, Month
ORDER BY Year, Month;

-- Revenue by Month Name (Seasonality)
SELECT 
    MonthName,
    SUM(Revenue) AS total_revenue
FROM sales_data
GROUP BY MonthName, Month
ORDER BY Month;

-- Revenue by Hour (Customer Behavior)
SELECT 
    Hour,
    SUM(Revenue) AS revenue_by_hour
FROM sales_data
GROUP BY Hour
ORDER BY Hour;


/* =========================
   4. PRODUCT ANALYSIS
   ========================= */

-- Top 10 Products by Revenue
SELECT TOP 10
    Description,
    SUM(Revenue) AS total_revenue
FROM sales_data
GROUP BY Description
ORDER BY total_revenue DESC;

-- Top 10 Products by Quantity
SELECT TOP 10
    Description,
    SUM(Quantity) AS total_quantity
FROM sales_data
GROUP BY Description
ORDER BY total_quantity DESC;


/* =========================
   5. CUSTOMER ANALYSIS
   ========================= */

-- Top 10 Customers by Revenue
SELECT TOP 10
    CustomerID,
    SUM(Revenue) AS total_spent
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC;

-- Customers with Most Orders
SELECT TOP 10
    CustomerID,
    COUNT(DISTINCT Invoice) AS total_orders
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_orders DESC;


/* =========================
   6. COUNTRY ANALYSIS
   ========================= */

-- Revenue by Country
SELECT 
    Country,
    SUM(Revenue) AS total_revenue
FROM sales_data
GROUP BY Country
ORDER BY total_revenue DESC;

-- Orders by Country
SELECT 
    Country,
    COUNT(DISTINCT Invoice) AS total_orders
FROM sales_data
GROUP BY Country
ORDER BY total_orders DESC;


/* =========================
   7. ADVANCED INSIGHTS
   ========================= */

-- Revenue Contribution by Country (%)
SELECT 
    Country,
    SUM(Revenue) AS total_revenue,
    SUM(Revenue) * 100.0 / SUM(SUM(Revenue)) OVER() AS revenue_percentage
FROM sales_data
GROUP BY Country
ORDER BY total_revenue DESC;


/* =========================================================
   END OF SCRIPT
   ========================================================= */