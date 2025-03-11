CREATE TABLE AdventureWorks2022.Sales.StoreNew(
stored_id INT PRIMARY KEY NOT NULL,
sale INT
)

CREATE TABLE AdventureWorks2022.Sales.Visits(
visit_id INT PRIMARY KEY IDENTITY (1,1),
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
visited_at DATETIME,
phone VARCHAR (20),
stored_id INT NOT NULL,
FOREIGN KEY (stored_id) REFERENCES sales.StoreNew(stored_id)
)


