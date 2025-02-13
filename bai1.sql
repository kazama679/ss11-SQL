USE session_11;

-- 2
delimiter &&
create procedure EmployeeBranch(EmployeeID int)
begin 
	select e.EmployeeID, e.FullName, e.Position, e.Salary, b.BranchName, b.Location from employees e
    join branch b on b.BranchID = e.BranchID
    where e.EmployeeID = EmployeeID;
end &&
delimiter ;

call EmployeeBranch(2);

-- 3
create view HighSalaryEmployees as 
select e.EmployeeID, e.FullName, e.Position, e.Salary from employees e
where e.Salary>=15000000 with check option;
-- 4
select * from HighSalaryEmployees;

drop view HighSalaryEmployees;

-- 5
select * from employees; 
alter table employees 
add column PhoneNumber varchar(15);
create view EmployeeBranch  as 
select e.EmployeeID, e.FullName, e.Position, e.Salary, e.PhoneNumber from employees e;
select * from EmployeeBranch;

-- 6
delete from employees e where BranchID in (select BranchID from branch where BranchName = "Chi nhánh Hà Nội");
-- trong view khoong xoa dc, phai xoa tu bang chinh trc