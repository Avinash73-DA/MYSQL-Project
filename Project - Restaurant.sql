-- View the menu_items table and write a query to find the number of items on the menu

 SELECT 
     item_name, COUNT(item_name) AS no_of_items
 FROM
     menu_items
 GROUP BY item_name WITH ROLLUP; 

-- What are the least and most expensive items on the menu?

 SELECT item_name AS Item, price FROM menu_items
 order by price;

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

 SELECT 
     item_name AS Item, 
     category, 
     price,
     COUNT(*) OVER (PARTITION BY category) AS COUNT
 FROM
     menu_items
 WHERE
     category = 'italian'
 ORDER BY price ;

-- How many dishes are in each category? What is the average dish price within each category?

 SELECT 
      category,
      COUNT(item_name) AS No_Of_Items,
      round(avg(price)) AS Avg_Price
 FROM
     menu_items
 GROUP BY category
 ORDER BY Avg_Price;

 select MIN(order_date), MAX(order_date) from order_details 

-- How many orders were made within this date range?

 select COUNT(distinct order_id) FROM order_details

-- How many items were ordered within this date range?

 select COUNT(*) FROM order_details

-- Which orders had the most number of items?

 CREATE VIEW Orders AS
 SELECT 
     order_id,
     COUNT(item_id) AS Items
 FROM
     order_details
 GROUP BY order_id
 order by Items desc;

 SELECT order_id,count(order_id) AS Count FROM Orders where items > 12
 GROUP BY order_id WITH ROLLUP;

 CREATE VIEW  join_order AS
 SELECT 
     *
 FROM
     order_details
    LEFT JOIN
     menu_items ON menu_items.menu_item_id = order_details.item_id;


-- What were the least and most ordered items? What categories were they in?



	
 SELECT 
     item_name, category, COUNT(item_name) AS Purchases
 FROM
     join_order
 GROUP BY item_name , category
 ORDER BY Purchases DESC;

-- What were the top 5 orders that spent the most money?


 SELECT 
     order_id, ROUND(SUM(price)) AS Price
 FROM
     join_order
 group by order_id
 order by Price desc 
 limit 5;

 SELECT 
     item_name,
     category,
     COUNT(item_name) AS Purchases,
     ROUND(SUM(price)) AS PRICE
 FROM
     join_order
 GROUP BY item_name , category , price
 ORDER BY PRICE DESC
 LIMIT 5
 ;

-- View the details of the highest spend order. Which specific items were purchased?

 SELECT 
     category, COUNT(item_id) AS Items
 FROM
     join_order
 where order_id  IN(440,2075,330,1957,2675)
 GROUP BY category;

SELECT 
    order_id, 
    SUM(price) AS total_order_price
FROM 
    join_order
GROUP BY 
    order_id
ORDER BY 
    total_order_price DESC
LIMIT 1;

