

CREATE DATABASE EmployeeManagementdb;
GO

USE EmployeeManagementdb;
GO

-- Create Departments Table

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


-- Create Employees Table


CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,

    FOREIGN KEY(DepartmentID)
    REFERENCES Departments(DepartmentID)
);


-- Insert Sample Data


INSERT INTO Departments VALUES
(1,'Human Resources'),
(2,'Information Technology'),
(3,'Finance'),
(4,'Marketing');

INSERT INTO Employees VALUES
(101,'John','Smith',2,60000,'2020-01-15'),
(102,'Alice','Johnson',1,45000,'2019-03-20'),
(103,'David','Brown',3,70000,'2021-06-10'),
(104,'Emma','Wilson',4,50000,'2022-02-18'),
(105,'Michael','Taylor',2,80000,'2018-11-25');


-- Display Tables


SELECT * FROM Departments;

SELECT * FROM Employees;






       -- Exercise 1 Simple View
GO
CREATE VIEW vw_EmployeeBasicInfo
AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

PRINT 'Exercise 1 Output';

SELECT *
FROM vw_EmployeeBasicInfo;
GO





       -- Exercise 2 Computed Column - Full Name
GO
CREATE VIEW vw_EmployeeFullName
AS
SELECT
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    DepartmentID,
    Salary
FROM Employees;
GO

PRINT 'Exercise 2 Output';

SELECT *
FROM vw_EmployeeFullName;
GO





--        Exercise 3 Annual Salary
GO
CREATE VIEW vw_EmployeeAnnualSalary
AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employees;
GO

PRINT 'Exercise 3 Output';

SELECT *
FROM vw_EmployeeAnnualSalary;
GO



--         Exercise 4 Employee Report
GO
CREATE VIEW vw_EmployeeReport
AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName,
    e.Salary * 12 AS AnnualSalary,
    (e.Salary * 12) * 0.10 AS Bonus
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

PRINT 'Exercise 4 Output';

SELECT *
FROM vw_EmployeeReport;
GO