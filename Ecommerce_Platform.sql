DROP DATABASE IF EXISTS Ecommerce;
CREATE DATABASE Ecommerce;
USE Ecommerce;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inserting dummy data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '987-654-3210', '456 Oak St'),
(3, 'Bob', 'Johnson', 'bob.johnson@email.com', '555-123-4567', '789 Pine St'),
(4, 'Alice', 'Williams', 'alice@email.com', '444-555-6666', '987 Cedar St'),
(5, 'Charlie', 'Brown', 'charlie@email.com', '777-888-9999', '654 Birch St'),
(6, 'Eva', 'Davis', 'eva@email.com', '333-222-1111', '321 Elm St'),
(7, 'Frank', 'Miller', 'frank@email.com', '111-222-3333', '876 Maple St'),
(8, 'Grace', 'Moore', 'grace@email.com', '666-777-8888', '543 Pine St'),
(9, 'Harry', 'Lee', 'harry@email.com', '222-333-4444', '210 Oak St'),
(10, 'Ivy', 'Chen', 'ivy@email.com', '999-888-7777', '109 Cedar St');

-- Inserting dummy data into Products table
INSERT INTO Products (ProductID, ProductName, Price, Category, StockQuantity)
VALUES
(1, 'Laptop', 999.99, 'Electronics', 50),
(2, 'Smartphone', 499.99, 'Electronics', 100),
(3, 'Headphones', 79.99, 'Electronics', 200),
(4, 'Tablet', 299.99, 'Electronics', 30),
(5, 'Coffee Maker', 49.99, 'Appliances', 80),
(6, 'Bluetooth Speaker', 89.99, 'Electronics', 150),
(7, 'Digital Camera', 399.99, 'Electronics', 25),
(8, 'Kitchen Mixer', 129.99, 'Appliances', 40),
(9, 'Fitness Tracker', 69.99, 'Wearables', 120),
(10, 'External Hard Drive', 129.99, 'Computers', 60);

-- Inserting dummy data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status)
VALUES
(101, 1, '2023-01-01',  'Shipped'),
(102, 2, '2023-02-15', 'Processing'),
(103, 3, '2023-03-10', 'Delivered'),
(104, 4, '2023-04-05',  'Shipped'),
(105, 5, '2023-05-20',  'Processing'),
(106, 6, '2023-06-15', 'Delivered'),
(107, 7, '2023-07-01', 'Shipped'),
(108, 8, '2023-08-18', 'Processing'),
(109, 9, '2023-09-25', 'Delivered'),
(110, 10, '2023-10-10', 'Shipped');

-- Inserting dummy data into OrderDetails table
TRUNCATE TABLE OrderDetails;
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(1001, 101, 1, 20),
(1002, 102, 2, 10),
(1003, 102, 3, 5),
(1004, 104, 4, 10),
(1005, 107, 5, 2),
(1006, 106, 3, 13),
(1007, 107, 7, 15),
(1008, 108, 3, 25),
(1009, 103, 9, 3),
(1010, 110, 10, 12);



-- Implement a query to find the total amount spent by a customer.
SELECT C.customerID, C.FirstName, P.productName, O.OrderID, sum(OD.Quantity * P.price) As TotalAmount
FROM orderDetails OD
	JOIN Orders O
		USING(orderID)
	JOIN customers C
		USING(CustomerID)
	JOIN products P 
		USING(productID)
GROUP BY OrderID, C.customerID, C.FirstName, P.productName, O.OrderID
ORDER BY TotalAmount desc;


-- Implement a query to find the best-selling product
SELECT p.productID, P.productName, sum(OD.Quantity) AS TotalQuantitySold
	FROM orderDetails OD
JOIN products P 
	USING(productID)
GROUP BY  P.productID, P.productName
ORDER BY TotalQuantitySold DESC
LIMIT 1