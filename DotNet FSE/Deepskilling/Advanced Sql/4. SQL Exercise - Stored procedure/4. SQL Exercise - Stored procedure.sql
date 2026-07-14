

-- Create Database


CREATE DATABASE EmployeeManagementSP;
GO

USE EmployeeManagementSP;
GO

-- Create Tables

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);
GO

-- Insert Sample Data


INSERT INTO Departments VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Marketing');

INSERT INTO Employees
(FirstName,LastName,DepartmentID,Salary,JoinDate)
VALUES
('John','Doe',1,5000,'2020-01-15'),
('Jane','Smith',2,6000,'2019-03-22'),
('Michael','Johnson',3,7000,'2018-07-30'),
('Emily','Davis',4,5500,'2021-11-05');
GO

SELECT * FROM Departments;
SELECT * FROM Employees;
GO


-- Exercise 1 Stored Procedure to Retrieve Employees by Department


GO
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID,
           FirstName,
           LastName,
           DepartmentID
    FROM Employees
    WHERE DepartmentID=@DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 1;
GO

-- Insert Employee Stored Procedure


GO
CREATE PROCEDURE sp_InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
AS
BEGIN
    INSERT INTO Employees
    (FirstName,LastName,DepartmentID,Salary,JoinDate)

    VALUES
    (@FirstName,@LastName,@DepartmentID,@Salary,@JoinDate);
END;
GO

EXEC sp_InsertEmployee
'Robert',
'Williams',
3,
8000,
'2024-05-01';

SELECT * FROM Employees;
GO


-- Exercise 2 Modify Stored Procedure

GO
ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID,
           FirstName,
           LastName,
           Salary,
           DepartmentID
    FROM Employees
    WHERE DepartmentID=@DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 3;
GO


-- Exercise 3 Delete Stored Procedure


DROP PROCEDURE sp_InsertEmployee;
GO
-- Exercise 4 Execute Stored Procedure

EXEC sp_GetEmployeesByDepartment 2;
GO

-- Exercise 5 Return Total Employees

GO
CREATE PROCEDURE sp_TotalEmployees
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID=@DepartmentID;
END;
GO

EXEC sp_TotalEmployees 3;
GO


-- Exercise 6 Output Parameter


GO
CREATE PROCEDURE sp_TotalSalary
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT
    @TotalSalary=SUM(Salary)

    FROM Employees

    WHERE DepartmentID=@DepartmentID;
END;
GO

DECLARE @Salary DECIMAL(10,2);

EXEC sp_TotalSalary
3,
@Salary OUTPUT;

SELECT @Salary AS TotalSalary;
GO

-- Exercise 7 Update Salary

GO
CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees

    SET Salary=@Salary

    WHERE EmployeeID=@EmployeeID;
END;
GO

EXEC sp_UpdateEmployeeSalary 1,5500;

SELECT * FROM Employees;
GO


-- Exercise 8 Give Bonus


GO
CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @Bonus DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees

    SET Salary=Salary+@Bonus

    WHERE DepartmentID=@DepartmentID;
END;
GO

EXEC sp_GiveBonus 1,500;

SELECT * FROM Employees;
GO


-- Exercise 9 Transaction

GO
CREATE PROCEDURE sp_UpdateSalaryTransaction
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN

BEGIN TRANSACTION;

BEGIN TRY

UPDATE Employees

SET Salary=@Salary

WHERE EmployeeID=@EmployeeID;

COMMIT TRANSACTION;

PRINT 'Salary Updated Successfully';

END TRY

BEGIN CATCH

ROLLBACK TRANSACTION;

PRINT 'Transaction Failed';

END CATCH

END;
GO

EXEC sp_UpdateSalaryTransaction 2,6500;

SELECT * FROM Employees;
GO
-- Exercise 10 Dynamic SQL

GO
CREATE PROCEDURE sp_SearchEmployee
    @ColumnName NVARCHAR(50),
    @Value NVARCHAR(50)
AS
BEGIN

DECLARE @SQL NVARCHAR(MAX);

SET @SQL='SELECT * FROM Employees
WHERE '+QUOTENAME(@ColumnName)+'='''+@Value+'''';

EXEC sp_executesql @SQL;

END;
GO

EXEC sp_SearchEmployee
'FirstName',
'John';
GO


-- Exercise 11 Error Handling


GO
CREATE PROCEDURE sp_UpdateSalaryErrorHandling
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN

BEGIN TRY

UPDATE Employees

SET Salary=@Salary

WHERE EmployeeID=@EmployeeID;

PRINT 'Salary Updated Successfully';

END TRY

BEGIN CATCH

PRINT 'Custom Error : Unable to Update Salary';

END CATCH

END;
GO

EXEC sp_UpdateSalaryErrorHandling
1,
7000;

SELECT * FROM Employees;
GO