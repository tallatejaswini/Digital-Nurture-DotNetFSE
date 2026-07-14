CREATE DATABASE OnlineRetailStore;
GO

USE OnlineRetailStore;
GO
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(50)
);

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails
(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customers VALUES
(1,'Alice','North'),
(2,'Bob','South'),
(3,'Charlie','East'),
(4,'David','West');

INSERT INTO Products VALUES
(1,'Laptop','Electronics',1200),
(2,'Smartphone','Electronics',800),
(3,'Tablet','Electronics',600),
(4,'Headphones','Accessories',150),
(5,'Keyboard','Accessories',150),
(6,'Monitor','Electronics',800);

INSERT INTO Orders VALUES
(1,1,'2025-01-10'),
(2,2,'2025-01-12'),
(3,3,'2025-02-05'),
(4,4,'2025-03-01'),
(5,1,'2025-03-10');

INSERT INTO OrderDetails VALUES
(1,1,1,1),
(2,2,2,2),
(3,3,3,1),
(4,4,4,3),
(5,5,6,2);
-- Exercise 1
SELECT
ProductName,
Category,
Price,

ROW_NUMBER() OVER
(
PARTITION BY Category
ORDER BY Price DESC
) AS RowNum

FROM Products;
-- Rank
SELECT
ProductName,
Category,
Price,

RANK() OVER
(
PARTITION BY Category
ORDER BY Price DESC
) AS RankNum

FROM Products;
-- DENSE_RANK()
SELECT
ProductName,
Category,
Price,

DENSE_RANK() OVER
(
PARTITION BY Category
ORDER BY Price DESC
) AS DenseRank

FROM Products;
--Top 3 Products
WITH ProductRanks AS
(
SELECT
ProductName,
Category,
Price,

ROW_NUMBER() OVER
(
PARTITION BY Category
ORDER BY Price DESC
) AS RowNum

FROM Products
)

SELECT *
FROM ProductRanks
WHERE RowNum<=3;

-- Exercise 2 GROUPING SETS
SELECT

c.Region,
p.Category,
SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID=c.CustomerID

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

GROUP BY GROUPING SETS
(
(c.Region,p.Category),
(c.Region),
(p.Category),
()
);

-- ROLLUP
SELECT

c.Region,
p.Category,
SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID=c.CustomerID

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

GROUP BY ROLLUP
(
c.Region,
p.Category
);
-- cube 
SELECT

c.Region,
p.Category,
SUM(od.Quantity) AS TotalQuantity

FROM Orders o

JOIN Customers c
ON o.CustomerID=c.CustomerID

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

GROUP BY CUBE
(
c.Region,
p.Category
);

-- Exercise 3 Recursive CTE
WITH Calendar AS
(
SELECT CAST('2025-01-01' AS DATE) AS DateValue

UNION ALL

SELECT DATEADD(DAY,1,DateValue)

FROM Calendar

WHERE DateValue<'2025-01-31'
)

SELECT *
FROM Calendar

OPTION(MAXRECURSION 100);

-- Create Staging Table
CREATE TABLE StagingProducts
(
ProductID INT,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);

-- insert data
INSERT INTO StagingProducts VALUES

(1,'Laptop','Electronics',1300),

(7,'Mouse','Accessories',50);

-- MERGE
MERGE Products AS Target

USING StagingProducts AS Source

ON Target.ProductID=Source.ProductID

WHEN MATCHED THEN

UPDATE SET

Target.Price=Source.Price

WHEN NOT MATCHED THEN

INSERT
(ProductID,ProductName,Category,Price)

VALUES
(
Source.ProductID,
Source.ProductName,
Source.Category,
Source.Price
);

-- Exercise 4 Monthly Sales

SELECT

p.ProductName,

MONTH(o.OrderDate) AS MonthNo,

SUM(od.Quantity) AS Qty

FROM Orders o

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

GROUP BY
p.ProductName,
MONTH(o.OrderDate);

-- PIVOT
SELECT *

FROM
(
SELECT

p.ProductName,

MONTH(o.OrderDate) AS MonthNo,

od.Quantity

FROM Orders o

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

) AS SourceTable

PIVOT
(
SUM(Quantity)

FOR MonthNo IN
(
[1],[2],[3]
)

) AS PivotTable;

-- UNPIVOT
SELECT *

FROM
(
SELECT *

FROM
(
SELECT

p.ProductName,

MONTH(o.OrderDate) AS MonthNo,

od.Quantity

FROM Orders o

JOIN OrderDetails od
ON o.OrderID=od.OrderID

JOIN Products p
ON od.ProductID=p.ProductID

) AS SourceTable

PIVOT
(
SUM(Quantity)

FOR MonthNo IN
(
[1],[2],[3]
)

) AS PivotTable

) P

UNPIVOT
(
Quantity

FOR MonthNo IN
(
[1],[2],[3]
)

) U;

-- Exercise 5
WITH CustomerOrderCounts AS
(

SELECT

CustomerID,

COUNT(OrderID) AS OrderCount

FROM Orders

GROUP BY CustomerID

)

SELECT

c.CustomerID,

c.Name,

OrderCount

FROM CustomerOrderCounts coc

JOIN Customers c

ON coc.CustomerID=c.CustomerID

WHERE OrderCount>3;

