CREATE DATABASE EmployeeManagementCursorDB;
GO

USE EmployeeManagementCursorDB;
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
(3,'Bob','Johnson',3,5500.00,'2021-07-30');
GO

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

-- Exercise 1

DECLARE
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE;

DECLARE EmployeeCursor CURSOR
FOR
SELECT *
FROM Employees;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN

    PRINT 'Employee ID: ' + CAST(@EmployeeID AS VARCHAR(10))
        + ', Name: ' + @FirstName + ' ' + @LastName
        + ', Department ID: ' + CAST(@DepartmentID AS VARCHAR(10))
        + ', Salary: ' + CAST(@Salary AS VARCHAR(20))
        + ', Join Date: ' + CAST(@JoinDate AS VARCHAR(20));

    FETCH NEXT FROM EmployeeCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;

END;

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;
GO

-- Exercise 2

DECLARE
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE;

PRINT 'STATIC CURSOR';

DECLARE StaticCursor CURSOR STATIC
FOR
SELECT *
FROM Employees;

OPEN StaticCursor;

FETCH NEXT FROM StaticCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FirstName;

    FETCH NEXT FROM StaticCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;
END;

CLOSE StaticCursor;
DEALLOCATE StaticCursor;

PRINT 'DYNAMIC CURSOR';

DECLARE DynamicCursor CURSOR DYNAMIC
FOR
SELECT *
FROM Employees;

OPEN DynamicCursor;

FETCH NEXT FROM DynamicCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FirstName;

    FETCH NEXT FROM DynamicCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;
END;

CLOSE DynamicCursor;
DEALLOCATE DynamicCursor;

PRINT 'FORWARD ONLY CURSOR';

DECLARE ForwardCursor CURSOR FORWARD_ONLY
FOR
SELECT *
FROM Employees;

OPEN ForwardCursor;

FETCH NEXT FROM ForwardCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FirstName;

    FETCH NEXT FROM ForwardCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;
END;

CLOSE ForwardCursor;
DEALLOCATE ForwardCursor;

PRINT 'KEYSET CURSOR';

DECLARE KeysetCursor CURSOR KEYSET
FOR
SELECT *
FROM Employees;

OPEN KeysetCursor;

FETCH NEXT FROM KeysetCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FirstName;

    FETCH NEXT FROM KeysetCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;
END;

CLOSE KeysetCursor;
DEALLOCATE KeysetCursor;
GO