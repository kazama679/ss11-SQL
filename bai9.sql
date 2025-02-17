use chinook;

-- 2
create view View_High_Value_Customers as
select c.CustomerId, concat(c.FirstName, ' ', c.LastName) as FullName, c.Email, sum(i.Total) as Total_Spending
from Customer c
join Invoice i on c.CustomerId = i.CustomerId
where i.InvoiceDate >= '2010-01-01' and c.Country <> 'Brazil'
group by c.CustomerId, c.FirstName, c.LastName, c.Email
having Total_Spending > 200;

select * from View_High_Value_Customers;

drop view View_High_Value_Customers;

-- 3
create view View_Popular_Tracks as
select t.TrackId, t.Name as Track_Name, sum(il.Quantity) as Total_Sales
from Track t
join InvoiceLine il on t.TrackId = il.TrackId
where il.UnitPrice > 1.00
group by t.TrackId, t.Name
having Total_Sales > 15;

-- 4
create index idx_Customer_Country 
on Customer (Country) using hash;
explain select * from Customer where Country = 'Canada';

-- 5
create fulltext index idx_Track_Name_FT 
on Track (Name);

explain select * from Track 
where match(Name) against('Love');

-- 6
explain select v.*
from View_High_Value_Customers v
join Customer c on v.CustomerId = c.CustomerId
where v.Total_Spending > 200 and c.Country = 'Canada';

-- 7
explain select v.*, t.UnitPrice 
from View_Popular_Tracks v
join Track t on v.TrackId = t.TrackId
where match(t.Name) against('Love');

-- 8
delimiter //
create procedure GetHighValueCustomersByCountry(in p_Country varchar(50))
begin
    select v.*
    from View_High_Value_Customers v
    join Customer c on v.CustomerId = c.CustomerId
    where c.Country = p_Country;
end //
delimiter ;

call GetHighValueCustomersByCountry('Canada');

-- 9
delimiter //
create procedure UpdateCustomerSpending(in p_CustomerId int, in p_Amount decimal(10,2))
begin update Invoice
set Total = Total + p_Amount
    where CustomerId = p_CustomerId
    order by InvoiceDate desc;
end //
delimiter ;

call UpdateCustomerSpending(5, 50.00);

select * from View_High_Value_Customers where CustomerId = 5;

-- 10
drop view if exists View_High_Value_Customers;
drop view if exists View_Popular_Tracks;
drop index idx_Customer_Country on Customer;
drop index idx_Track_Name_FT on Track;
drop procedure if exists GetHighValueCustomersByCountry;
drop procedure if exists UpdateCustomerSpending;