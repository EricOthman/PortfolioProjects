
#Top Customers with highest order
SELECT m.first_name,m.surname,m.sex, c.city, ROUND(sum(o.total_order)) AS TotalOrders
FROM Restaruant.members m
JOIN cities c ON m.city_id = c.id
JOIN orders o on m.id = o.member_id
GROUP BY m.first_name,m.surname,m.sex, c.city
ORDER BY sum(o.total_order) desc

#City and Sex with the most orders
SELECT c.city,m.sex, ROUND(sum(o.total_order)) AS TotalOrders
FROM Restaruant.members m
JOIN cities c ON m.city_id = c.id
JOIN orders o on m.id = o.member_id
GROUP BY c.city, m.sex
ORDER BY sum(o.total_order) desc

#Months with the most orders
SELECT MONTH(date), ROUND(sum(total_order)) AS TotalOrders
FROM Orders
GROUP BY MONTH(date)
ORDER BY MONTH(date) asc

#Months and Cities which made the most orders
SELECT MONTH(o.date),c.city, ROUND(sum(o.total_order)) AS TotalOrders
FROM Restaruant.members m
JOIN cities c ON m.city_id = c.id
JOIN orders o on m.id = o.member_id
GROUP BY MONTH(date),c.city
ORDER BY MONTH(date) asc

#Months of which sex made the most orders
SELECT MONTH(o.date),m.sex, ROUND(sum(o.total_order)) AS TotalOrders
FROM Restaruant.members m
JOIN cities c ON m.city_id = c.id
JOIN orders o on m.id = o.member_id
GROUP BY MONTH(date),m.sex
ORDER BY MONTH(date) asc

#Ratio of meal types in restaurant in each city
SELECT c.city, mt.meal_type, COUNT(*) as Num_restaruants, COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY c.city) AS Ratio
FROM restaurants r
JOIN meals m ON m.restaurant_id = r.id
JOIN meal_types mt on m.meal_type_id = mt.id
JOIN restaurant_types rt ON r.restaurant_type_id = rt.id
JOIN cities c ON r.city_id = c.id
JOIN serve_types st ON m.serve_type_id = st.id
GROUP BY c.city, mt.meal_type


#Total orders with restaurant type and city
SELECT rt.restaurant_type,c.city,ROUND(SUM(o.total_order)) as TotalOrder
FROM orders o
JOIN members m ON o.member_id = m.id
JOIN restaurants r ON o.restaurant_id = r.id
JOIN cities c on r.city_id = c.id
JOIN restaurant_types rt ON r.restaurant_type_id = rt.id
GROUP BY rt.restaurant_type,c.city
ORDER BY rt.restaurant_type,c.city desc


#Cities with the most vegan meals
SELECT c.city, COUNT(*) as Num_vegan_meals
FROM restaurants r
JOIN meals m ON r.id = m.restaurant_id
JOIN cities c ON r.city_id = c.id
JOIN meal_types mt ON m.meal_type_id = mt.id
WHERE mt.meal_type = 'Vegan'
GROUP BY c.city
ORDER BY Num_vegan_meals DESC

#Difference in the range of price of the hot or cold meals
SELECT hot_cold, MAX(price) - MIN(price) AS price_range_difference
FROM meals
GROUP BY hot_cold


#Which sex did the most orders
SELECT m.sex, ROUND(SUM(total_order)) AS Total_order
FROM Orders o
JOIN members m ON o.member_id = m.id
GROUP BY m.sex

