-- 1. CUSTOMER Table
CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Father_Name VARCHAR(100),
    Grandfather_Name VARCHAR(100),
    Kebele_ID VARCHAR(50),
    Phone VARCHAR(20),
    Address VARCHAR(100),
    Email VARCHAR(100)
);
-- 2. BRANCH Table
CREATE TABLE BRANCH (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100),
    Location VARCHAR(100),
    Region VARCHAR(50),
    Manager_ID INT
);
-- 3. EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    Employee_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Job_Title VARCHAR(50),
    Branch_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);
-- 4. ACCOUNT Table
CREATE TABLE ACCOUNT (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Branch_ID INT,
    Account_Type VARCHAR(50),
    Balance DECIMAL(12,2),
    Date_Opened DATE,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);
-- 5. TRANSACTION Table
CREATE TABLE TRANSACTION (
    Transaction_ID INT PRIMARY KEY,
    Account_No INT,
    Type VARCHAR(50),
    Amount DECIMAL(12,2),
    Date DATE,
    Time TIME,
    Performed_By INT,
    FOREIGN KEY (Account_No) REFERENCES ACCOUNT(Account_No)
);
-- 6. LOAN Table
CREATE TABLE LOAN (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Amount DECIMAL(12,2),
    Loan_Type VARCHAR(50),
    Interest_Rate DECIMAL(5,2),
    Period INT,
    Status VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);
-- 7. LOAN_REPAYMENT Table
CREATE TABLE LOAN_REPAYMENT (
    Repayment_ID INT PRIMARY KEY,
    Loan_ID INT,
    Amount_Paid DECIMAL(12,2),
    Payment_Date DATE,
    Remaining_Balance DECIMAL(12,2),
    FOREIGN KEY (Loan_ID) REFERENCES LOAN(Loan_ID)
);
-- 8. ATM_CARD Table
CREATE TABLE ATM_CARD (
    Card_ID INT PRIMARY KEY,
    Account_No INT,
    Card_Number VARCHAR(50),
    Card_Type VARCHAR(50),
    Status VARCHAR(20),
    Expiry_Date DATE,
    FOREIGN KEY (Account_No) REFERENCES ACCOUNT(Account_No)
);
-- 9. MOBILE_BANKING Table
CREATE TABLE MOBILE_BANKING (
    Service_ID INT PRIMARY KEY,
    Customer_ID INT,
    Phone_Number VARCHAR(20),
    Username VARCHAR(50),
    Status VARCHAR(20),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);
-- 4. SQL DML – INSERT SAMPLE DATA
-- 1. Insert Into CUSTOMER
INSERT INTO CUSTOMER VALUES
(1, 'Abebe Mekonnen', 'Mekonnen', 'Wolde', 'KBL12345', '0911223344', 'Addis Ababa', 'abebe@gmail.com'),
(2, 'Sara Alemu', 'Alemu', 'Kebede', 'KBL98765', '0911556677', 'Hawassa', 'saraalemu@gmail.com');

-- 2. Insert Into BRANCH
INSERT INTO BRANCH VALUES
(101, 'Arat Kilo Branch', 'Addis Ababa', 'Addis Ababa', 501),
(102, 'Piazza Branch', 'Addis Ababa', 'Addis Ababa', 502);

-- 3. Insert Into EMPLOYEE
INSERT INTO EMPLOYEE VALUES
(501, 'Kassahun Bekele', 'Branch Manager', 101, 15000.00),
(502, 'Lily Tsegaye', 'Accountant', 101, 9500.00);

-- 4. Insert Into ACCOUNT
INSERT INTO ACCOUNT VALUES
(10001, 1, 101, 'Savings', 4500.00, '2022-01-12'),
(10002, 2, 102, 'Current', 12000.00, '2023-03-15');

-- 5. Insert Into TRANSACTION
INSERT INTO TRANSACTION VALUES
(7001, 10001, 'Deposit', 2000.00, '2023-06-10', '10:00:00', 502),
(7002, 10002, 'Withdrawal', 1000.00, '2023-06-12', '15:40:00', 501);

-- 6. Insert Into LOAN
INSERT INTO LOAN VALUES
(9001, 1, 50000.00, 'Personal', 12.5, 24, 'Approved'),
(9002, 2, 250000.00, 'Business', 14.0, 36, 'Pending');

-- 7. Insert Into LOAN_REPAYMENT
INSERT INTO LOAN_REPAYMENT VALUES
(1, 9001, 2000.00, '2024-01-10', 48000.00),
(2, 9001, 2500.00, '2024-02-10', 45500.00);

-- 8. Insert Into ATM_CARD
INSERT INTO ATM_CARD VALUES
(3001, 10001, '4567-1234-9876-2345', 'Visa', 'Active', '2027-12-31'),
(3002, 10002, '4567-4321-1234-9876', 'Mastercard', 'Active', '2028-01-10');

-- 9. Insert Into MOBILE_BANKING
INSERT INTO MOBILE_BANKING VALUES
(2001, 1, '0911223344', 'abebeM', 'Active'),
(2002, 2, '0911556677', 'saraA', 'Inactive');

-- 5. BASIC SQL QUERIES (DML – SELECT, UPDATE, DELETE)
-- 1. List all customers
SELECT * FROM CUSTOMER;
-- 2. Show all accounts with customer names
SELECT ACCOUNT.Account_No, CUSTOMER.Full_Name, ACCOUNT.Balance
FROM ACCOUNT
JOIN CUSTOMER ON ACCOUNT.Customer_ID = CUSTOMER.Customer_ID;
-- 3. Show all loans with customer information
SELECT LOAN.Loan_ID, CUSTOMER.Full_Name, LOAN.Amount, LOAN.Status
FROM LOAN
JOIN CUSTOMER ON LOAN.Customer_ID = CUSTOMER.Customer_ID;
-- UPDATE Queries
-- 1. Update customer phone number
UPDATE CUSTOMER
SET Phone = '0911000000'
WHERE Customer_ID = 1;
-- 2. Increase account balance
UPDATE ACCOUNT
SET Balance = Balance + 500.00
WHERE Account_No = 10002;
-- DELETE Queries
-- 1. Delete a mobile banking record
DELETE FROM MOBILE_BANKING
WHERE Service_ID = 2002;
