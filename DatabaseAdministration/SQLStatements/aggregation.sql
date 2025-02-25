SELECT COUNT(*) AS total_orders, 
       AVG(OrderAmount) AS avg_order_amount, 
       MIN(OrderAmount) AS min_order_amount, 
       MAX(OrderAmount) AS max_order_amount 
FROM UserOrders;