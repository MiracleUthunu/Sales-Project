SELECT *
FROM SalesProject..SalesReport
ORDER BY 2, 3;

SELECT Segment, SUM(Gross_Sales) AS total_gross_sales
FROM SalesProject..SalesReport
GROUP BY Segment;

--Total gross sale by country
SELECT country, SUM(Gross_Sales) AS total_gross_sales
FROM SalesProject..SalesReport
GROUP BY Country;

--Top Selling Products in a country by total sales
SELECT Product, Country, SUM(Gross_Sales) AS total_gross_sales
FROM SalesProject..SalesReport
GROUP BY Product, Country
ORDER BY total_gross_sales DESC;


---Profit Monthly Trend
SELECT Date, SUM(Profit) AS monthly_profit
FROM SalesProject..SalesReport
GROUP BY Date

--Profit margin between products
SELECT Country, AVG(profit_margin) AS avg_profit_margin
FROM(
     SELECT Country, Product, SUM(Profit) / SUM(Gross_Sales) AS profit_margin
	 FROM SalesProject..SalesReport
	 GROUP BY Country, Product
) AS Subquery
GROUP BY Country;


--impact of Discount on sales and profit
SELECT Discoun_Band, SUM(Gross_Sales) AS total_gross_sales, SUM(Profit) AS total_profit
FROM SalesProject..SalesReport
GROUP BY Discoun_Band

---Cost Analysis
--total cost of goods sold per country
SELECT Country, SUM(COGS) AS total_cogs
FROM SalesProject..SalesReport
GROUP BY Country;

--Average manufacturing price per product
SELECT Product, AVG(Manufacturing_Price) AS avg_manufacturing_price
FROM SalesProject..SalesReport
GROUP BY Product;

--Manufacturing Prices across different countries
SELECT Country, AVG(Manufacturing_Price) AS avg_manufacturing_price
FROM SalesProject..SalesReport
GROUP BY Country;

--Calculation of KPIs
SELECT Product, SUM(Profit) / SUM(Gross_Sales) AS profit_margin, SUM(Profit) / SUM(COGS) AS return_on_investment, SUM(Gross_Sales) / SUM(COGS) AS sales_to_cost_ratio
FROM SalesProject..SalesReport
GROUP BY Product;


--Seasonal trends in discount and profit_margin
SELECT Date, Segment, AVG(profit_margin) AS avg_profit_margin
FROM(
   SELECT Date, Segment, AVG(Discounts) AS avg_discounts, SUM(Profit) / SUM(Gross_Sales) AS profit_margin
   FROM SalesProject..SalesReport
   GROUP BY Date, Segment
) AS Subquery
GROUP BY Date, Segment


--Market Share for each product relative to market within the same Country
SELECT Product, Country, SUM(Units_Sold) / (SELECT SUM(Units_Sold) FROM SalesProject..SalesReport WHERE Country = main.Country) AS market_share
FROM SalesProject..SalesReport main
GROUP BY Product, Country;


--Forecasting future sales
SELECT Date, SUM(Gross_Sales) AS total_gross_sales, AVG(Gross_Sales) OVER (ORDER BY Date, Date ROWS BETWEEN 3 PRECEDING AND 1 FOLLOWING) AS moving_avg_sales
FROM SalesProject..SalesReport
GROUP BY Date, Gross_Sales

