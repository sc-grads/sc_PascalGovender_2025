SELECT FirstName, LastName, AmountPaid, 
       CASE 
           WHEN AmountPaid > 300 THEN 'High' 
           WHEN AmountPaid BETWEEN 100 AND 300 THEN 'Medium' 
           ELSE 'Low' 
       END AS PaymentCategory
FROM Users;
