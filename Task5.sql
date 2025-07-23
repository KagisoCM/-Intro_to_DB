-- JOIN examples
SELECT s.FirstName, s.LastName, o.OrderDate, o.Total
FROM Students s
INNER JOIN Orders o ON s.StudentID = o.CustomerID;

SELECT p.ProductName, p.Price, o.OrderDate
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.OrderID;

-- Aggregation examples
SELECT Category, AVG(Price) AS AvgPrice, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category;

SELECT Department, COUNT(*) AS EmployeeCount, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- Subquery examples
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT FirstName, LastName
FROM Students
WHERE StudentID IN (SELECT DISTINCT CustomerID FROM Orders);

-- Window functions
SELECT 
    ProductName,
    Category,
    Price,
    RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRank
FROM Products;

SELECT 
    Department,
    Name,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS DeptAvgSalary
FROM Employees;

-- Common Table Expressions
WITH HighValueOrders AS (
    SELECT * FROM Orders WHERE Total > 100
)
SELECT s.FirstName, s.LastName, h.OrderDate, h.Total
FROM HighValueOrders h
JOIN Students s ON h.CustomerID = s.StudentID;
