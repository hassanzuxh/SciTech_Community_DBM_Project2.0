DROP DATABASE IF EXISTS LibraryManagement;
CREATE DATABASE LibraryManagement;
USE LibraryManagement;


CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    CONSTRAINT uc_username UNIQUE (UserName)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    AuthorID INT,
    ISBN VARCHAR(13) UNIQUE,
    CONSTRAINT FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    UserID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    CONSTRAINT  FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT  FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Insert dummy data into Authors table
INSERT INTO Authors (AuthorID, AuthorName) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Robert Johnson'),
(4, 'Emily White'),
(5, 'Michael Brown'),
(6, 'Sophie Miller'),
(7, 'Daniel Davis'),
(8, 'Olivia Taylor'),
(9, 'William Turner'),
(10, 'Ella Harris');

-- Insert dummy data into Books table
INSERT INTO Books (BookID, Title, AuthorID, ISBN) VALUES
(101, 'The Mystery of the Lost Key', 1, '1234567890123'),
(102, 'Programming Basics', 2, '9876543210987'),
(103, 'History of Science', 3, '4567890123456'),
(104, 'The Coding Odyssey', 2, '1111222233334'),
(105, 'Romance in the Rain', 5, '5555666677778'),
(106, 'The Art of Cooking', 6, '9999888877776'),
(107, 'Into the Wilderness', 7, '4444333322221'),
(108, 'Science Fiction Wonders', 8, '8765432109876'),
(109, 'Exploring Nature', 9, '1357924680246'),
(110, 'Poetry Anthology', 10, '2468135790246');

-- Insert dummy data into Users table
INSERT INTO Users (UserID, UserName, Email) VALUES
(1001, 'user1', 'user1@example.com'),
(1002, 'user2', 'user2@example.com'),
(1003, 'user3', 'user3@example.com'),
(1004, 'user4', 'user4@example.com'),
(1005, 'user5', 'user5@example.com'),
(1006, 'user6', 'user6@example.com'),
(1007, 'user7', 'user7@example.com'),
 (1008, 'user8', 'user8@example.com'),
(1009, 'user9', 'user9@example.com'),
(1010, 'user10', 'user10@example.com');

-- Insert corrected dummy data into Transactions table to show many-to-many relationship
TRUNCATE TABLE Transactions;
INSERT INTO Transactions (TransactionID, UserID, BookID, BorrowDate, ReturnDate) VALUES
(10016, 1001, 103, '2023-06-10', '2023-06-25'),
(10017, 1001, 105, '2023-07-15', '2023-07-30'),
(10018, 1002, 105, '2023-08-20', '2023-09-04'),
(10019, 1002, 107, '2023-09-25', '2023-10-10'),
(10020, 1003, 109, '2023-10-30', '2023-11-14'),
(10021, 1004, 110, '2023-11-19', '2023-12-04'),
(10022, 1004, 101, '2023-12-09', '2023-12-24'),
(10023, 1005, 102, '2024-01-01', '2024-01-15'),
(10024, 1005, 103, '2024-02-01', '2024-02-16'),
(10025, 1005, 105, '2024-03-01', '2024-03-16');

-- Implement a query to find the books borrowed by a specific reader
SELECT U.userID, U.username, B.BookID, B.Title, A.AuthorID, A.AuthorName
FROM transactions
LEFT JOIN Users U
 USING (UserID)
 LEFT JOIN Books B
 USING (BookID)
 LEFT JOIN Authors A
 USING (AuthorID)
 WHERE U.username= 'user5';

-- implement the query to find the most borrowed books
SELECT T.BookID, B.Title, COUNT(T.BookID) AS "HighestBorrowed"
FROM Books B
JOIN Transactions T
	USING (bookID)
GROUP BY T.BookID, B.Title
ORDER BY COUNT(T.BookID) DESC;



SELECT COUNT(AuthorID) AS AuthorCount, COUNT(DISTINCT AuthorID) As UniqueCount
FROM  Books;

SELECT   userID 
FROM  transactions
QUALIFY ROW_NUMBER() OVER (PARTITION BY ID 
