use chinook;

-- 2
create view View_Track_Details as 
select t.TrackId, t.name as Track_Name, a.Title as Album_Title, ar.name as Artist_Name, t.UnitPrice from Track t
join Album a on a.AlbumId = t.AlbumId
join Artist ar on ar.ArtistId = a.ArtistId
where t.UnitPrice >0.99;

select * from View_Track_Details;

drop view View_Track_Details;

-- 3
create view View_Customer_Invoice as 
select c.customerid, concat(c.lastname, ' ', c.firstname) as fullname, c.email, sum(i.total) as total_spending, concat(e.lastname, ' ', e.firstname) as support_rep 
from customer c
join invoice i on i.customerid = c.customerid
join employee e on e.employeeid = c.supportrepid 
group by c.customerid, c.lastname, c.firstname, c.email, e.lastname, e.firstname
having total_spending > 50;

select * from View_Customer_Invoice;

drop view View_Customer_Invoice;

-- 4
create view View_Top_Selling_Tracks as 
select t.trackid, t.name as track_name, g.name as genre_name, sum(i.quantity) as total_sales from track t
join genre g on g.genreid = t.genreid
join invoiceline i on i.trackid = t.trackid
group by t.trackid, t.name, g.name
having total_sales > 10;

select * from View_Top_Selling_Tracks;

drop view View_Top_Selling_Tracks;

-- 5 
create index idx_Track_Name on track(name) using btree;

select * from track where name like '%Love%';

explain select * from track where name like '%Love%';

-- 6
create index idx_Invoice_Total on invoice(total);

select * from invoice where total between 20 and 100;

explain select * from invoice where total between 20 and 100;

-- 7
delimiter &&
create procedure GetCustomerSpending(CustomerId int)
begin 
	select ifnull(total_spending, 0) as total_spending from View_Customer_Invoice v
    where v.CustomerId = CustomerId;
end &&
delimiter ;

call GetCustomerSpending(1);

drop procedure GetCustomerSpending;

-- 8
delimiter &&
create procedure SearchTrackByKeyword(in p_Keyword varchar(255))
begin
    select * 
    from track 
    where name like concat('%', p_Keyword, '%');
end &&
delimiter ;

call SearchTrackByKeyword('lo');

drop procedure SearchTrackByKeyword;

-- 9
delimiter &&
create procedure GetTopSellingTracks(p_MinSales int, p_MaxSales int)
begin 
	select * from View_Top_Selling_Tracks
    where Total_Sales between p_MinSales and p_MaxSales;
end &&
delimiter ;

call GetTopSellingTracks(1, 5);

drop procedure GetTopSellingTracks;

-- 10 da xoa