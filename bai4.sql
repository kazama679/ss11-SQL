DROP DATABASE IF EXISTS session_11;
CREATE DATABASE session_11;
USE session_11;
-- Bảng Branch (Chi nhánh)
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL
);
-- Bảng Employees (Nhân viên)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL,
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
-- Bảng Customers (Khách hàng)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
-- Bảng Accounts (Tài khoản)
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    AccountType ENUM('Saving', 'Current', 'Fixed Deposit') NOT NULL,
    Balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    OpenDate DATE NOT NULL,
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
-- Bảng Transactions (Giao dịch khách hàng)
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT NOT NULL,
    TransactionType ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
-- Bảng Loans (Khoản vay ngân hàng)
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    LoanType ENUM('Home Loan', 'Car Loan', 'Personal Loan', 'Business Loan') NOT NULL,
    LoanAmount DECIMAL(15,2) NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL,
    LoanTerm INT NOT NULL, 
    StartDate DATE NOT NULL,
    Status ENUM('Active', 'Closed') DEFAULT 'Active',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- Thêm mới chi nhánh
INSERT INTO Branch (BranchName, Location, PhoneNumber) VALUES
('Chi nhánh Hà Nội', '123 Trần Hưng Đạo, Hà Nội', '024-12345678'),
('Chi nhánh TP.HCM', '456 Lê Lợi, TP.HCM', '028-87654321'),
('Chi nhánh Đà Nẵng', '789 Nguyễn Văn Linh, Đà Nẵng', '026-576646598');
-- Thêm mới nhân viên
INSERT INTO Employees (EmployeeID, FullName, Position, Salary, HireDate, BranchID) VALUES
(1, 'Nguyễn Văn An', 'Giám đốc', 45000000, '2018-03-10', 1),
(2, 'Trần Thị Hạnh', 'Giao dịch viên', 15000000, '2021-06-20', 2),
(3, 'Lê Minh Tuấn', 'Kế toán', '10000000', '2022-01-05', 3),
(4, 'Phạm Hoàng Kiên', 'Sale', 18000000, '2023-05-12', 1),
(5, 'Đặng Hữu Bình', 'Quản lý', 32000000, '2023-06-12', 2);
-- Thêm mới khách hàng
INSERT INTO Customers (CustomerID, FullName, DateOfBirth, Address, PhoneNumber, Email, BranchID) VALUES
(1, 'Nguyễn Văn Hùng', '1990-07-15', 'Hà Nội', '0901234567', 'hung.nguyen@gmail.com', 1),
(2, 'Phạm Văn Dũng', '1985-09-25', NULL, '0912345678', 'dung.pham@gmail.com', 2),
(3, 'Hoàng Thanh Tùng', '1993-11-30', 'Đà Nẵng', '0922334455', 'tung@gmail.com', 3),
(4, 'Lê Minh Khoa', '1988-04-12', 'Huế', '0945124578', 'khoa.le@gmail.com', 2),
(5, 'Đỗ Hoàng Anh', '1995-07-19', 'Cần Thơ', '0978123456', 'hoanganh.do@gmail.com', 1);
-- Thêm mới tài khoản
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, OpenDate, BranchID) VALUES
(1, 1, 'Saving', 5000000, '2023-01-01', 1),
(2, 1, 'Current', 15000000, '2023-10-12', 1), 
(3, 2, 'Current', 12000000, '2023-02-15', 2),
(4, 3, 'Saving', 7000000, '2023-05-10', 1),
(5, 4, 'Fixed Deposit', 50000000, '2023-06-20', 2),
(6, 1, 'Fixed Deposit', 80000000, '2023-11-05', 2),
(7, 3, 'Saving', 3000000, '2023-08-14', 3),
(8, 5, 'Current', 1200000, '2024-01-10', 2),
(9, 5, 'Saving', 2000000, '2024-05-20', 1);
-- Thêm mới giao dịch
INSERT INTO Transactions (TransactionID, AccountID, TransactionType, Amount, TransactionDate) VALUES
(1, 1, 'Deposit', 2000000, '2024-02-01 10:15:00'),
(2, 1, 'Withdrawal', 1000000, NULL),
(3, 2, 'Deposit', 5000000, '2024-02-03 09:00:00'),
(4, 3, 'Withdrawal', 3000000, '2024-02-04 14:30:00'),
(5, 4, 'Transfer', 2500000, '2024-02-05 09:45:00'),
(6, 5, 'Deposit', 1000000, '2024-02-06 16:20:00'),
(7, 3, 'Transfer', 2000000, NULL),
(8, 2, 'Withdrawal', 500000, '2024-02-08 11:55:00');
-- Thêm mới khoản vay
INSERT INTO Loans (CustomerID, LoanType, LoanAmount, InterestRate, LoanTerm, StartDate, Status) VALUES
(1, 'Home Loan', 500000000.00, 6.5, 240, '2023-03-01', 'Active'),
(1, 'Car Loan', 300000000.00, 7.0, 120, '2023-04-15', 'Active'),
(2, 'Personal Loan', 150000000.00, 10.0, 36, '2023-07-10', 'Active'),
(3, 'Home Loan', 600000000.00, 5.8, 180, '2023-09-05', 'Active'),
(3, 'Car Loan', 250000000.00, 3.7, 60, '2023-10-10', 'Active'),
(4, 'Personal Loan', 150000000.00, 9.5, 48, '2023-11-20', 'Active'),
(5, 'Home Loan', 700000000.00, 5.9, 42, '2023-12-01', 'Active'),
(1, 'Business Loan', 900000000.00, 8.0, 120, '2024-01-05', 'Active'),
(5, 'Car Loan', 300000000.00, 7.2, 72, '2024-07-25', 'Active');

-- 2 
delimiter &&
create procedure UpdateSalaryByID(EmployeeID int, INOUT SalaryC decimal(10,2))
begin 
	update employees e
    set 
		Salary = CASE
			when SalaryC<20000000 then Salary*1.1
            else SalaryC*1.05
		end
	where e.EmployeeID = EmployeeID;
    SELECT Salary FROM Employees WHERE Employees.EmployeeID = EmployeeID;
end &&
delimiter ;

set @Salary=21000000;
call UpdateSalaryByID(2, @Salary);
drop procedure UpdateSalaryByID;

-- 3
delimiter &&
create procedure GetLoanAmountByCustomerID(Customer_ID int, out LoanAmount_out decimal(15))
begin 
	SELECT COALESCE(SUM(l.LoanAmount), 0)
    INTO LoanAmount_out
    FROM loans l
    WHERE l.CustomerID = Customer_ID;
end &&
delimiter ;

call GetLoanAmountByCustomerID(1, @LoanAmount_out);
SELECT @LoanAmount_out;
drop procedure GetLoanAmountByCustomerID;

-- 4
delimiter &&  
create procedure deleteaccountiflowbalance(in acc_id int)  
begin  
    declare current_balance decimal(15,2);  
    declare account_exists int;  
    select count(*) into account_exists from accounts where accountid = acc_id;  
    if account_exists = 0 then  
        select 'tài khoản không tồn tại' as message;  
    else  
        select balance into current_balance from accounts where accountid = acc_id;
        if current_balance < 1000000 then  
            delete from accounts where accountid = acc_id;
            select 'tài khoản đã được xóa thành công' as message;
        else  
            select 'không thể xóa tài khoản vì số dư lớn hơn hoặc bằng 1 triệu' as message;
        end if;
    end if;
end &&  
delimiter ;  

call deleteaccountiflowbalance(3);

drop procedure deleteaccountiflowbalance;

-- 5
delimiter &&  
create procedure transfermoney(in from_account int, in to_account int, inout amount decimal(15,2))  
begin  
    declare is_exists bit default 0;  
    declare is_morethan bit default 0;  
    declare current_balance decimal(15,2);  
    if (select count(accountid) from accounts where accountid = from_account) > 0  
        and (select count(accountid) from accounts where accountid = to_account) > 0 then  
        set is_exists = 1;  
    end if;  
    if is_exists = 1 then  
        select balance into current_balance from accounts where accountid = from_account;  
        if current_balance >= amount then  
            set is_morethan = 1;  
        end if;  
    end if;  
    if is_morethan = 1 then  
        update accounts  
        set balance = balance - amount  
        where accountid = from_account;  
        update accounts  
        set balance = balance + amount  
        where accountid = to_account;  
    else  
        set amount = 0;  
    end if;  
end &&  
delimiter ;  

set @transfer_amount = 500000; 
call transfermoney(1, 2, @transfer_amount); 
select @transfer_amount;  

drop procedure TransferMoney;

-- 6
set @salary = 18000000; 
call updatesalarybyid(4, @salary);

call getloanamountbycustomerid(1, @loanamount_out);
select @loanamount_out as totalloanamount;

call deleteaccountiflowbalance(8);

set @transferamount = 2000000;
call transfermoney(1, 3, @transferamount);

select @transferamount as finaltransferredamount;

drop procedure if exists updatesalarybyid;
drop procedure if exists getloanamountbycustomerid;
drop procedure if exists deleteaccountiflowbalance;
drop procedure if exists transfermoney;