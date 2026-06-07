create database ProductDB;

use ProductDB;

CREATE TABLE Products
(
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQty INT
);

CREATE TABLE Product_Audit
(
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ActionType VARCHAR(20),
    ActionDate DATETIME
);

-- 2.	Create BEFORE INSERT trigger to validate product price.
-- Requirement:
-- If the product price is:
-- ●	NULL 
-- ●	0 
-- ●	Negative 
-- then assign a default price of 100.
DELIMITER $$

CREATE TRIGGER trg_before_product_insert
BEFORE INSERT
ON Products
FOR EACH ROW
BEGIN

    -- Validate Price

    IF NEW.Price IS NULL OR NEW.Price <= 0 THEN
        SET NEW.Price = 100;
    END IF;

    -- Validate Stock

    IF NEW.StockQty IS NULL THEN
        SET NEW.StockQty = 10;
    END IF;

END$$

DELIMITER ;

-- 4. 
DELIMITER $$

CREATE TRIGGER trg_after_product_insert
AFTER INSERT
ON Products
FOR EACH ROW
BEGIN

    INSERT INTO Product_Audit
    (
        ProductID,
        ProductName,
        ActionType,
        ActionDate
    )
    VALUES
    (
        NEW.ProductID,
        NEW.ProductName,
        'INSERT',
        NOW()
    );

END$$

DELIMITER ;

INSERT INTO Products
(ProductName, Category, Price, StockQty)
VALUES
('Laptop', 'Electronics', 55000, 20),
('Mobile', 'Electronics', 25000, 50),
('Mouse', 'Accessories', 800, 100),
('Keyboard', 'Accessories', 1500, 75);

INSERT INTO Products
(ProductName, Category, Price, StockQty)
VALUES
('USB Cable', 'Accessories', -50, 100),
('Webcam', 'Electronics', 0, 25),
('Speaker', 'Electronics', NULL, 15),
('Printer', 'Electronics', 15000, NULL),
('Scanner', 'Electronics', 12000, 12),
('Hard Disk', 'Storage', -500, NULL),
('SSD', 'Storage', 4500, 30);

SELECT * FROM Products;

SELECT * FROM Product_Audit;
 
 SHOW TRIGGERS;