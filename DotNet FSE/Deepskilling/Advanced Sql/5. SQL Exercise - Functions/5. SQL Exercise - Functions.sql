CREATE DATABASE EmployeeManagementFunctions;
GO

USE EmployeeManagementFunctions;
GO

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);
GO

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000.00,'2020-01-15'),
(2,'Jane','Smith',2,6000.00,'2019-03-22'),
(3,'Bob','Johnson',3,5500.00,'2021-07-01');
GO

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- Exercise 1

GO
CREATE FUNCTION fn_CalculateAnnualSalary
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 12;
END;
GO

SELECT
EmployeeID,
FirstName,
Salary,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

-- Exercise 2

GO
CREATE FUNCTION fn_GetEmployeesByDepartment
(
    @DepartmentID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Employees
    WHERE DepartmentID=@DepartmentID
);
GO

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(2);
GO

-- Exercise 3

GO
CREATE FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

SELECT
EmployeeID,
FirstName,
Salary,
dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

-- Exercise 4

GO
ALTER FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

SELECT
EmployeeID,
FirstName,
Salary,
dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

-- Exercise 5

DROP FUNCTION fn_CalculateBonus;
GO

SELECT name
FROM sys.objects
WHERE type='FN';
GO

-- Exercise 6

SELECT
EmployeeID,
FirstName,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

-- Exercise 7

SELECT
EmployeeID,
FirstName,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees
WHERE EmployeeID=1;
GO

GO
CREATE FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- Exercise 8

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(3);
GO

-- Exercise 9

GO
CREATE FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN
    dbo.fn_CalculateAnnualSalary(@Salary)
    +
    dbo.fn_CalculateBonus(@Salary);
END;
GO

SELECT
EmployeeID,
FirstName,
Salary,
dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO

-- Exercise 10

GO
ALTER FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN
    dbo.fn_CalculateAnnualSalary(@Salary)
    +
    (@Salary * 0.20);
END;
GO

SELECT
EmployeeID,
FirstName,
Salary,
dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO