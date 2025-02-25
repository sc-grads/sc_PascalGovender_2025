SELECT
    u.country,
    AVG(u.amountpaid) AS avg_amount_paid
FROM users AS u
GROUP BY u.country
HAVING AVG(u.amountpaid) > 200;
--having is a filter(where) after aggregation takes place--
