SELECT
    COUNT(*) AS total_orders,
    AVG(orderamount) AS avg_order_amount,
    MIN(orderamount) AS min_order_amount,
    MAX(orderamount) AS max_order_amount
FROM userorders;
