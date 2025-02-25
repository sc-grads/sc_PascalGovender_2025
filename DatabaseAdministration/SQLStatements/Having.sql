SELECT u.Country, AVG(u.AmountPaid) AS avg_amount_paid 
FROM Users u 
GROUP BY u.Country 
HAVING AVG(u.AmountPaid) > 200;
--having is a filter(where) after aggregation takes place--