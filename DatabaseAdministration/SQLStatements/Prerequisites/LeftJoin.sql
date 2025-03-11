--using a LEFT JOIN to show all users, even if they don't have an order--

SELECT
    U.FIRSTNAME,
    U.LASTNAME,
    U.EMAIL,
    O.ORDERID,
    O.ORDERAMOUNT,
    O.ORDERDATE
FROM USERS AS U
LEFT JOIN USERORDERS AS O ON U.USERID = O.USERID;
GO
