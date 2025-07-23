-- =============================================
-- DATABASE SETUP (DDL)
-- =============================================
DROP DATABASE IF EXISTS school_db;
CREATE DATABASE school_db;
USE school_db;

-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    EnrollmentDate DATE
);

-- Create Orders table with foreign key relationship
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Students(StudentID)
);

-- =============================================
-- SAMPLE DATA INSERTION (DML - CREATE)
-- =============================================
-- Insert sample students
INSERT INTO Students (StudentID, FirstName, LastName, Email, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john@example.com', '2022-01-15'),
(2, 'Jane', 'Smith', 'jane@example.com', '2022-03-22'),
(3, 'Michael', 'Johnson', 'michael@example.com', '2021-11-03'),
(4, 'Emily', 'Williams', 'emily@example.com', '2023-02-10');

-- Insert sample orders
INSERT INTO Orders (CustomerID, OrderDate, Total) VALUES
(1, '2023-01-10', 125.50),
(2, '2023-01-15', 89.99),
(1, '2023-02-05', 220.00),
(3, '2023-02-12', 54.75),
(4, '2023-03-01', 175.25);

-- =============================================
-- CRUD OPERATIONS PRACTICE
-- =============================================

-- CREATE (INSERT) Operations
INSERT INTO Students (StudentID, FirstName, LastName, Email, EnrollmentDate)
VALUES (5, 'David', 'Brown', 'david@example.com', '2023-04-05');

INSERT INTO Orders (CustomerID, OrderDate, Total)
VALUES (2, '2023-04-10', 199.99);

-- READ (SELECT) Operations
-- All orders on specific date
SELECT * FROM Orders WHERE OrderDate = '2023-01-15';

-- Orders with customer details
SELECT o.OrderID, s.FirstName, s.LastName, s.Email, o.OrderDate, o.Total
FROM Orders o
JOIN Students s ON o.CustomerID = s.StudentID
WHERE o.CustomerID = 1;

-- Students enrolled after Jan 1, 2022
SELECT * FROM Students WHERE EnrollmentDate > '2022-01-01';

-- UPDATE Operations
-- Update order total
UPDATE Orders SET Total = 135.00 WHERE OrderID = 2;

-- Update student email
UPDATE Students SET Email = 'john.doe@newmail.com' WHERE StudentID = 1;

-- DELETE Operations
-- Delete specific order
DELETE FROM Orders WHERE OrderID = 4;

-- Delete students enrolled before 2022
DELETE FROM Students WHERE EnrollmentDate < '2022-01-01';

-- =============================================
-- VERIFICATION QUERIES
-- =============================================
-- View all students
SELECT * FROM Students ORDER BY EnrollmentDate DESC;

-- View all orders with customer names
SELECT o.OrderID, s.FirstName, s.LastName, o.OrderDate, o.Total
FROM Orders o
JOIN Students s ON o.CustomerID = s.StudentID
ORDER BY o.OrderDate DESC;

-- Order count per student
SELECT s.StudentID, s.FirstName, s.LastName, COUNT(o.OrderID) AS OrderCount
FROM Students s
LEFT JOIN Orders o ON s.StudentID = o.CustomerID
GROUP BY s.StudentID;

-- =============================================
-- ADVANCED CRUD EXAMPLES (CORRECTED)
-- =============================================
-- Bulk update (10% increase for early orders)
UPDATE Orders 
SET Total = Total * 1.10 
WHERE OrderDate < '2023-03-01';

-- Conditional delete (remove small orders)
DELETE FROM Orders WHERE Total < 60.00;

-- Complex read with aggregation (CORRECTED VERSION)
SELECT 
    s.StudentID, 
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    SUM(o.Total) AS TotalSpent, 
    COUNT(o.OrderID) AS NumberOfOrders
FROM Students s
JOIN Orders o ON s.StudentID = o.CustomerID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY s.StudentID
HAVING COUNT(o.OrderID) > 0
ORDER BY TotalSpent DESC