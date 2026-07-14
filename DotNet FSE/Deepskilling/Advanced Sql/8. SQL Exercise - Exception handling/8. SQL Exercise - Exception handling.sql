CREATE DATABASE EmployeeManagementExceptionHandling;
GO

USE EmployeeManagementExceptionHandling;
GO

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);

CREATE TABLE AuditLog
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Action VARCHAR(100),
    ErrorMessage VARCHAR(4000),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Departments VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Marketing');

SELECT * FROM Departments;
GO

-- Exercise 1

GO
CREATE PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN
    BEGIN TRY

        INSERT INTO Employees
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );

        PRINT 'Employee Inserted Successfully';

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog(Action,ErrorMessage)
        VALUES
        (
            'Insert Employee',
            ERROR_MESSAGE()
        );

        PRINT 'Error Logged';

    END CATCH
END;
GO

EXEC AddEmployee
1,'John','Doe','john@gmail.com',5000,1;

EXEC AddEmployee
2,'Jane','Smith','john@gmail.com',6000,2;

SELECT * FROM Employees;
SELECT * FROM AuditLog;
GO

-- Exercise 2

GO
ALTER PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN

BEGIN TRY

INSERT INTO Employees
VALUES
(
@EmployeeID,
@FirstName,
@LastName,
@Email,
@Salary,
@DepartmentID
);

END TRY

BEGIN CATCH

INSERT INTO AuditLog(Action,ErrorMessage)
VALUES
(
'Insert Employee',
ERROR_MESSAGE()
);

THROW;

END CATCH

END;
GO

EXEC AddEmployee
3,'Bob','Johnson','john@gmail.com',7000,3;
GO

-- Exercise 3

GO
ALTER PROCEDURE AddEmployee
(
@EmployeeID INT,
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(100),
@Salary DECIMAL(10,2),
@DepartmentID INT
)
AS
BEGIN

IF @Salary<=0
BEGIN
RAISERROR('Salary must be greater than zero.',16,1);
RETURN;
END

BEGIN TRY

INSERT INTO Employees
VALUES
(
@EmployeeID,
@FirstName,
@LastName,
@Email,
@Salary,
@DepartmentID
);

END TRY

BEGIN CATCH

INSERT INTO AuditLog(Action,ErrorMessage)
VALUES
(
'Insert Employee',
ERROR_MESSAGE()
);

THROW;

END CATCH

END;
GO

EXEC AddEmployee
4,'Emily','Davis','emily@gmail.com',-500,2;
GO

-- Exercise 4

GO
CREATE PROCEDURE TransferEmployee
(
@EmployeeID INT,
@DepartmentID INT
)
AS
BEGIN

BEGIN TRY

BEGIN TRY

IF NOT EXISTS
(
SELECT *
FROM Departments
WHERE DepartmentID=@DepartmentID
)
BEGIN

RAISERROR('Department does not exist.',16,1);

END

UPDATE Employees
SET DepartmentID=@DepartmentID
WHERE EmployeeID=@EmployeeID;

END TRY

BEGIN CATCH

INSERT INTO AuditLog(Action,ErrorMessage)
VALUES
(
'Transfer Employee',
ERROR_MESSAGE()
);

THROW;

END CATCH

END TRY

BEGIN CATCH

PRINT ERROR_MESSAGE();

END CATCH

END;
GO

EXEC TransferEmployee
1,10;

SELECT * FROM AuditLog;
GO

-- Exercise 5

GO
CREATE PROCEDURE BatchInsertEmployees
AS
BEGIN

BEGIN TRY

BEGIN TRANSACTION;

INSERT INTO Employees
VALUES
(5,'Alex','Roy','alex@gmail.com',5000,1);

INSERT INTO Employees
VALUES
(6,'Chris','Martin','alex@gmail.com',6000,2);

COMMIT TRANSACTION;

END TRY

BEGIN CATCH

ROLLBACK TRANSACTION;

INSERT INTO AuditLog(Action,ErrorMessage)
VALUES
(
'Batch Insert',
ERROR_MESSAGE()
);

PRINT 'Transaction Rolled Back';

END CATCH

END;
GO

EXEC BatchInsertEmployees;

SELECT * FROM Employees;
SELECT * FROM AuditLog;
GO

-- Exercise 6

GO
ALTER PROCEDURE AddEmployee
(
@EmployeeID INT,
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Email VARCHAR(100),
@Salary DECIMAL(10,2),
@DepartmentID INT
)
AS
BEGIN

IF @Salary<0
BEGIN
RAISERROR('Salary cannot be negative.',16,1);
RETURN;
END

IF @Salary<1000
BEGIN
RAISERROR('Salary is very low.',10,1);
END

BEGIN TRY

INSERT INTO Employees
VALUES
(
@EmployeeID,
@FirstName,
@LastName,
@Email,
@Salary,
@DepartmentID
);

PRINT 'Employee Added';

END TRY

BEGIN CATCH

INSERT INTO AuditLog(Action,ErrorMessage)
VALUES
(
'Insert Employee',
ERROR_MESSAGE()
);

THROW;

END CATCH

END;
GO

EXEC AddEmployee
7,'David','Lee','david@gmail.com',800,1;

EXEC AddEmployee
8,'Tom','Wilson','tom@gmail.com',-200,2;

SELECT * FROM Employees;
SELECT * FROM AuditLog;
GO