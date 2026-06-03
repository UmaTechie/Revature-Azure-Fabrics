-- Medical Distribution SQL Assignment
use medicaldistribution;

CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY AUTO_INCREMENT,
    ManufacturerName VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50) NOT NULL,
    LicenseNo VARCHAR(30) UNIQUE,
    CreatedDate DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Distributor (
    DistributorID INT PRIMARY KEY,
    DistributorName VARCHAR(100) NOT NULL,
    GSTNumber VARCHAR(20) UNIQUE,
    City VARCHAR(50) DEFAULT 'Chennai',
    ContactNo VARCHAR(15) NOT NULL
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ManufacturerID INT,
    UnitPrice DECIMAL(10,2) CHECK(UnitPrice > 0),
    StockQty INT CHECK(StockQty >= 0),
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (ManufacturerID)
    REFERENCES Manufacturer(ManufacturerID)
);

CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY,
    HospitalName VARCHAR(100) NOT NULL,
    RegistrationNo VARCHAR(30) UNIQUE,
    City VARCHAR(50) NOT NULL
);

CREATE TABLE Pharmacy (
    PharmacyID INT PRIMARY KEY,
    PharmacyName VARCHAR(100) NOT NULL,
    LicenseNo VARCHAR(30) UNIQUE,
    ContactNo VARCHAR(15) NOT NULL
);

CREATE TABLE SalesRepresentative (
    RepID INT PRIMARY KEY,
    RepName VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2) DEFAULT 25000 CHECK(Salary > 0),
    DistributorID INT,
    FOREIGN KEY (DistributorID)
    REFERENCES Distributor(DistributorID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    DistributorID INT,
    HospitalID INT,
    OrderDate DATE NOT NULL,
    OrderAmount DECIMAL(12,2) CHECK(OrderAmount > 0),

    FOREIGN KEY (DistributorID)
    REFERENCES Distributor(DistributorID),

    FOREIGN KEY (HospitalID)
    REFERENCES Hospital(HospitalID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK(Quantity > 0),
    UnitPrice DECIMAL(10,2) CHECK(UnitPrice > 0),

    PRIMARY KEY (OrderID, ProductID),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
    ON DELETE CASCADE,

    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);

CREATE TABLE Shipment (
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    ShipmentDate DATE NOT NULL,
    Status VARCHAR(20)
    CHECK(Status IN ('Pending','Shipped','Delivered')),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,

    Amount DECIMAL(12,2)
    CHECK(Amount > 0),

    PaymentMode VARCHAR(20)
    CHECK(PaymentMode IN ('Cash','UPI','Card','NEFT')),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);

show tables;

INSERT INTO Manufacturer
(ManufacturerID,ManufacturerName,Country,LicenseNo)
VALUES
(1,'MedLife Pharma','India','LIC1001'),
(2,'HealthCare Labs','India','LIC1002'),
(3,'BioCure Pharma','USA','LIC1003'),
(4,'Apex Medicines','UK','LIC1004'),
(5,'Global Drugs','Germany','LIC1005');

INSERT INTO Distributor VALUES
(101,'South Medical Distributors','GST1001','Chennai','9876543210'),
(102,'Health Supply Chain','GST1002','Bangalore','9876543211'),
(103,'Pharma Logistics','GST1003','Hyderabad','9876543212'),
(104,'Care Distributors','GST1004','Mumbai','9876543213'),
(105,'Med Express','GST1005','Delhi','9876543214');

INSERT INTO Product VALUES
(1001,'Paracetamol 500mg',1,15.50,5000,'2027-12-31'),
(1002,'Amoxicillin 250mg',2,45.00,3000,'2027-08-15'),
(1003,'Vitamin C Tablets',3,10.00,4500,'2028-01-31'),
(1004,'Insulin Injection',4,250.00,1000,'2026-10-31'),
(1005,'BP Control Tablet',5,75.00,2500,'2027-05-30');

INSERT INTO Hospital VALUES
(201,'Apollo Hospital','REG1001','Chennai'),
(202,'Fortis Hospital','REG1002','Bangalore'),
(203,'Global Hospital','REG1003','Hyderabad'),
(204,'Care Hospital','REG1004','Mumbai'),
(205,'Medway Hospital','REG1005','Chennai'),
(206,'SIMS Hospital','REG1006','Chennai'),
(207,'Manipal Hospital','REG1007','Bangalore'),
(208,'Rainbow Hospital','REG1008','Hyderabad'),
(209,'MGM Hospital','REG1009','Chennai'),
(210,'Kauvery Hospital','REG1010','Trichy');

INSERT INTO Pharmacy VALUES
(301,'Apollo Pharmacy','PH1001','9000011111'),
(302,'MedPlus','PH1002','9000011112'),
(303,'NetMeds Store','PH1003','9000011113'),
(304,'Wellness Forever','PH1004','9000011114'),
(305,'Care Pharmacy','PH1005','9000011115'),
(306,'Trust Pharmacy','PH1006','9000011116'),
(307,'Health Pharmacy','PH1007','9000011117'),
(308,'MedCare Pharmacy','PH1008','9000011118'),
(309,'LifeCare Pharmacy','PH1009','9000011119'),
(310,'City Pharmacy','PH1010','9000011120');

INSERT INTO SalesRepresentative
(RepID, RepName, Salary, DistributorID)
VALUES
(401,'Rajesh Kumar',35000,101),
(402,'Priya Sharma',32000,102),
(403,'Arun Kumar',30000,103),
(404,'Kiran Rao',34000,104),
(405,'Vijay Kumar',36000,105),
(406,'Suresh Babu',33000,101),
(407,'Anita Singh',31000,102),
(408,'Deepak Verma',37000,103),
(409,'Lakshmi Devi',34000,104),
(410,'Ramesh Gupta',35000,105);

INSERT INTO Orders
(OrderID, DistributorID, HospitalID, OrderDate, OrderAmount)
VALUES
(5001,101,201,'2026-06-01',25000),
(5002,102,202,'2026-06-02',35000),
(5003,103,203,'2026-06-03',45000),
(5004,104,204,'2026-06-04',28000),
(5005,105,205,'2026-06-05',55000),
(5006,101,206,'2026-06-06',30000),
(5007,102,207,'2026-06-07',42000),
(5008,103,208,'2026-06-08',38000),
(5009,104,209,'2026-06-09',47000),
(5010,105,210,'2026-06-10',60000);

INSERT INTO OrderDetails
(OrderID, ProductID, Quantity, UnitPrice)
VALUES
(5001,1001,500,15.50),
(5001,1002,200,45.00),
(5002,1003,1000,10.00),
(5002,1005,300,75.00),
(5003,1004,100,250.00),
(5003,1001,600,15.50),
(5004,1005,250,75.00),
(5005,1002,400,45.00),
(5006,1003,800,10.00),
(5007,1004,120,250.00);

INSERT INTO Shipment
(ShipmentID, OrderID, ShipmentDate, Status)
VALUES
(7001,5001,'2026-06-02','Delivered'),
(7002,5002,'2026-06-03','Shipped'),
(7003,5003,'2026-06-04','Pending'),
(7004,5004,'2026-06-05','Delivered'),
(7005,5005,'2026-06-06','Shipped'),
(7006,5006,'2026-06-07','Delivered'),
(7007,5007,'2026-06-08','Pending'),
(7008,5008,'2026-06-09','Shipped'),
(7009,5009,'2026-06-10','Delivered'),
(7010,5010,'2026-06-11','Pending');

INSERT INTO Payments
(PaymentID, OrderID, Amount, PaymentMode)
VALUES
(8001,5001,25000,'UPI'),
(8002,5002,35000,'Card'),
(8003,5003,45000,'NEFT'),
(8004,5004,28000,'Cash'),
(8005,5005,55000,'UPI'),
(8006,5006,30000,'Card'),
(8007,5007,42000,'NEFT'),
(8008,5008,38000,'Cash'),
(8009,5009,47000,'UPI'),
(8010,5010,60000,'Card');

SELECT * FROM Manufacturer;
SELECT * FROM Distributor;
SELECT * FROM Product;
SELECT * FROM Hospital;
SELECT * FROM Pharmacy;
SELECT * FROM SalesRepresentative;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Shipment;
SELECT * FROM Payments;

SELECT *
FROM Product p
JOIN Manufacturer m
ON p.ManufacturerID = m.ManufacturerID;

SELECT *
FROM Orders o
JOIN Distributor d
ON o.DistributorID = d.DistributorID
JOIN Hospital h
ON o.HospitalID = h.HospitalID;

SELECT *
FROM OrderDetails
WHERE OrderID = 5001;

SHOW CREATE TABLE OrderDetails;

DELETE FROM Orders
WHERE OrderID = 5001;

SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalSold
FROM Product p
JOIN OrderDetails od
ON p.ProductID=od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;

SELECT
    h.HospitalName,
    SUM(o.OrderAmount) AS TotalSales
FROM Hospital h
JOIN Orders o
ON h.HospitalID=o.HospitalID
GROUP BY h.HospitalName
ORDER BY TotalSales DESC;

SELECT *
FROM Shipment
WHERE Status='Pending';

SELECT
    ProductID,
    ProductName,
    StockQty
FROM Product
WHERE StockQty < 2000;

SELECT
    d.DistributorName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.OrderAmount) AS TotalSales
FROM Distributor d
JOIN Orders o
ON d.DistributorID=o.DistributorID
GROUP BY d.DistributorName
ORDER BY TotalSales DESC;

/*Subqueries assignment*/
CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    ManagerID INT,
    HireDate DATE
);

INSERT INTO Employees
(EmployeeID, EmployeeName, Department, Salary, ManagerID, HireDate)
VALUES
(101, 'John', 'Sales', 50000.00, 201, '2021-01-10'),
(102, 'Mary', 'Sales', 65000.00, 201, '2020-03-15'),
(103, 'David', 'HR', 55000.00, 202, '2022-05-20'),
(104, 'Sophia', 'HR', 70000.00, 202, '2019-07-18'),
(105, 'James', 'IT', 80000.00, 203, '2018-11-01'),
(106, 'Emma', 'IT', 75000.00, 203, '2021-09-25'),
(107, 'Michael', 'Finance', 90000.00, 204, '2017-06-12'),
(108, 'Olivia', 'Finance', 60000.00, 204, '2023-02-01');

-- 1. Find employees earning more than the average salary.
select EmployeeId, EmployeeName, Department, Salary from Employees
where salary > (Select avg(Salary) From Employees);

-- 2. Find employees earning the highest salary.
select * From Employees
where Salary = (Select max(Salary) From Employees);

-- 3. Find employees earning the second highest salary.
select * from Employees 
where Salary = (Select max(salary) From Employees 
                  where Salary < (select max(salary) From Employees));
                  
-- 4. List employees whose salary is less than the maximum salary.
select * from Employees
where salary < (select max(salary) from Employees);

-- 5. Find employees working in the same department as the employee with the highest salary.
select * from Employees
where Department IN(select Department from Employees 
                    where salary = (select max(salary) from employees));  
                    
-- 6. Find departments having employees with salary greater than 70,000.
select EmployeeId, EmployeeName, Department from Employees where salary > 70000      

-- 7. Find employees whose salary is above their department average salary.
select EmployeeId, EmployeeName, Department, salary from Employees e 
where salary > (select Avg(salary) from Employees
				where Department = e.department); 
                
-- 8. Find employees who earn more than all employees in the HR department.
select EmployeeId, EmployeeName, Department, Salary from Employees where salary > (select max(salary) from Employees where Department = 'Hr');  

-- 9. Find employees whose salary matches any salary in the Sales department.
select * from Employees where salary In (select salary From Employees where Department = 'Sales'); 

-- 10. Find employees hired after the employee with the lowest salary.
select * from employees where hiredate > (select hiredate from employees where salary = (select Min(salary) from Employees));  

-- 11. Find the department with the highest average salary.
SELECT Department, AvgSalary FROM (SELECT Department, AVG(Salary) AS AvgSalary FROM Employees
GROUP BY Department) AS DeptAvg WHERE AvgSalary = (SELECT MAX(AvgSalary) 
                                FROM (SELECT AVG(Salary) AS AvgSalary FROM Employees GROUP BY Department) AS AvgTable);

-- 12. Find employees who earn the minimum salary in their department.
select EmployeeId, EmployeeName, Department, Salary from Employees e where salary = (select min(salary) from Employees where department = e.department)

-- 13. Display managers who manage employees earning more than 75,000.
select Distinct ManagerId from Employees where salary > 75000

-- 14. Find employees whose salary is greater than their manager's salary (assume managers are employees).
SELECT e.EmployeeName, e.Salary, m.EmployeeName AS ManagerName, m.Salary AS ManagerSalary FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;    

-- 15. Find the top 3 highest paid employees using a subquery.
SELECT * FROM Employees
WHERE Salary IN(SELECT Salary FROM(SELECT DISTINCT Salary FROM Employees
ORDER BY Salary DESC LIMIT 3) AS TopSalaries)
ORDER BY Salary DESC;  

use medicaldistribution;

-- Window Functions Assignment
Create Table ProductOrders(
    OrderID INT,
    OrderDate DATE,
    CustomerID INT,
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    SalesAmount DECIMAL(12,2),
    PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO ProductOrders VALUES
(1,'2026-01-05',1001,101,'Laptop','Electronics',2,60000,120000),
(1,'2026-01-05',1001,102,'Mobile','Electronics',1,25000,25000),
(2,'2026-01-10',1002,103,'Printer','Electronics',3,12000,36000),
(3,'2026-01-15',1003,104,'Desk','Furniture',2,8000,16000),
(3,'2026-01-15',1003,105,'Chair','Furniture',4,3000,12000),
(4,'2026-02-05',1004,101,'Laptop','Electronics',1,60000,60000),
(4,'2026-02-05',1004,103,'Printer','Electronics',2,12000,24000),
(5,'2026-02-10',1005,102,'Mobile','Electronics',3,25000,75000),
(5,'2026-02-10',1005,104,'Desk','Furniture',1,8000,8000),
(6,'2026-03-01',1006,105,'Chair','Furniture',5,3000,15000),
(7,'2026-03-05',1007,101,'Laptop','Electronics',2,60000,120000),
(8,'2026-03-12',1008,102,'Mobile','Electronics',4,25000,100000);

select * from ProductOrders

-- 1.Generate ROW_NUMBER() for products ordered by SalesAmount descending.
select ProductName, SalesAmount, Row_Number() OVER(ORDER BY SalesAmount DESC) As RowNum from ProductOrders;

-- 2. Assign RANK() to products based on total sales.
Select ProductName, sum(SalesAmount) as TotalSales, Rank() OVER(ORDER BY sum(SalesAmount) DESC) As Ranking from ProductOrders group by ProductName;

-- 3. Assign DENSE_RANK() to products based on quantity sold.
select ProductName, sum(Quantity), dense_rank() OVER(Order By sum(Quantity) DESC) As Quantity_Sold from ProductOrders group by ProductName;

-- 4. Find the Top 3 selling products.
SELECT * FROM(SELECT ProductName, SUM(SalesAmount) AS TotalSales,
           DENSE_RANK() OVER(ORDER BY SUM(SalesAmount) DESC) AS rnk
              FROM ProductOrders GROUP BY ProductName) x WHERE rnk <= 3;

-- 5. Display previous SalesAmount using LAG().
select OrderId, ProductName, SalesAmount, lag(SalesAmount) OVER(order by OrderDate desc) AS PreviousAmount FROM ProductOrders;

-- 6. Display next SalesAmount using LEAD().
select OrderId, ProductName, SalesAmount, lead(SalesAmount) OVER(Order by OrderDate desc) AS NextAmount From ProductOrders;

-- 7. Calculate running total of SalesAmount by OrderDate.
select OrderDate, ProductName, SalesAmount, sum(SalesAmount) OVER(Order by OrderDate desc) AS TotalRunningAmount From ProductOrders;

-- 8. Calculate cumulative sales for each product.
SELECT ProductName, OrderDate, SalesAmount, SUM(SalesAmount)
       OVER(PARTITION BY ProductName ORDER BY OrderDate) AS CumulativeSales FROM ProductOrders;
       
-- 9. Show highest sales in each category using FIRST_VALUE().
SELECT ProductName, Category, SalesAmount,
       FIRST_VALUE(SalesAmount) OVER(PARTITION BY Category ORDER BY SalesAmount DESC) AS HighestSales FROM ProductOrders;
       
-- 10. Show lowest sales in each category using LAST_VALUE().
SELECT ProductName, Category, SalesAmount, LAST_VALUE(SalesAmount)
       OVER(PARTITION BY Category ORDER BY SalesAmount
           ROWS BETWEEN UNBOUNDED PRECEDING
           AND UNBOUNDED FOLLOWING) AS LowestSales FROM ProductOrders;
           
-- 11. Calculate difference between current and previous sales.
SELECT ProductName, SalesAmount, SalesAmount -LAG(SalesAmount)
					OVER(ORDER BY OrderDate) AS Difference FROM ProductOrders;
                    
-- 12. Calculate 3-order moving average sales.
SELECT OrderID, ProductName, SalesAmount, AVG(SalesAmount) OVER(ORDER BY OrderDate
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage FROM ProductOrders;
           
-- 13. Show percentage contribution of each product to total sales.
SELECT ProductName, SalesAmount,
       ROUND(SalesAmount * 100.0 /SUM(SalesAmount) OVER(),2) AS PercentageContribution FROM ProductOrders;
       
-- 14. Find products whose sales exceed category average.
SELECT * FROM(SELECT ProductName, Category, SalesAmount, AVG(SalesAmount)
		 OVER(PARTITION BY Category) AS CategoryAvg
              FROM ProductOrders) x WHERE SalesAmount > CategoryAvg;
              
-- 15. Divide products into quartiles using NTILE(4).
SELECT ProductName, SalesAmount, NTILE(4)
       OVER(ORDER BY SalesAmount DESC) AS Quartile FROM ProductOrders;
       
-- 16. Find second highest selling product.
SELECT ProductName, TotalSales FROM(SELECT ProductName,
           SUM(SalesAmount) AS TotalSales, DENSE_RANK()
           OVER(ORDER BY SUM(SalesAmount) DESC) AS rnk FROM ProductOrders GROUP BY ProductName) x WHERE rnk = 2;
           
-- 17. Compare each product with category leader sales.
SELECT ProductName, Category, SalesAmount,
       FIRST_VALUE(SalesAmount) OVER(PARTITION BY Category ORDER BY SalesAmount DESC) AS CategoryLeaderSales,
       SalesAmount - FIRST_VALUE(SalesAmount)
       OVER(PARTITION BY Category ORDER BY SalesAmount DESC) AS Difference FROM ProductOrders;
       
-- 18. Calculate month-over-month sales growth.
WITH MonthlySales AS
(
    SELECT DATE_FORMAT(OrderDate,'%Y-%m') AS SalesMonth,
           SUM(SalesAmount) AS TotalSales
    FROM ProductOrders
    GROUP BY DATE_FORMAT(OrderDate,'%Y-%m')
)
SELECT SalesMonth, TotalSales, LAG(TotalSales)
       OVER(ORDER BY SalesMonth) AS PreviousMonthSales,
       TotalSales - LAG(TotalSales) OVER(ORDER BY SalesMonth) AS Growth FROM MonthlySales;
       
-- 19. Identify products with consecutive sales increases using LAG().
SELECT * FROM(SELECT ProductName, OrderDate, SalesAmount, LAG(SalesAmount)
           OVER(PARTITION BY ProductName ORDER BY OrderDate) AS PreviousSales
              FROM ProductOrders) AS x WHERE SalesAmount > PreviousSales;
              
-- 20. Create a sales leaderboard using DENSE_RANK().
SELECT ProductName, SUM(SalesAmount) AS TotalSales,
       DENSE_RANK() OVER(ORDER BY SUM(SalesAmount) DESC) AS LeaderBoardRank
FROM ProductOrders GROUP BY ProductName;