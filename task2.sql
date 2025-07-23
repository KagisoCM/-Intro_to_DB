-- Create a new database (if you don't have one already)
CREATE DATABASE company;
USE company;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    hire_date DATE NOT NULL,
    INDEX idx_hire_date (hire_date),
    INDEX idx_last_name (last_name)
);
INSERT INTO Employees (first_name, last_name, department, hire_date)
VALUES 
    ('John', 'Doe', 'Sales', '2020-05-15'),
    ('Jane', 'Smith', 'Marketing', '2021-02-10'),
    ('Michael', 'Johnson', 'IT', '2019-11-03'),
    ('Emily', 'Williams', 'HR', '2022-07-22'),
    ('David', 'Brown', 'Sales', '2023-01-30'),
    ('Sarah', 'Miller', 'IT', '2021-08-14'),
    ('Robert', 'Wilson', 'Finance', '2020-12-05'),
    ('Lisa', 'Taylor', 'Marketing', '2023-03-18'),
    ('James', 'Anderson', 'HR', '2018-06-09'),
    ('Patricia', 'Thomas', 'Finance', '2022-11-27');
    -- Query for employees hired after January 1, 2021, ordered by last name
SELECT 
    employee_id AS 'ID',
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    department AS 'Department',
    hire_date AS 'Hire Date'
FROM 
    Employees 
WHERE 
    hire_date > '2021-01-01'
ORDER BY 
    last_name ASC;
    -- View all employees to verify your data
SELECT * FROM Employees ORDER BY hire_date DESC;

-- Count employees by department
SELECT department, COUNT(*) AS employee_count
FROM Employees
GROUP BY department
ORDER BY employee_count DESC;