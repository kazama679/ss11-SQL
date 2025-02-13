use chinook;

-- 3
create view View_Album_Artist as 
select al.AlbumId, al.Title as Album_Title, ar.name as Artist_Name from album al
join artist ar on ar.ArtistId = al.ArtistId;	

select * from View_Album_Artist;

drop view View_Album_Artist;

-- 4
create view View_Customer_Spending as 
select c.CustomerId, c.FirstName, c.LastName, c.Email, sum(i.total) as Total_Spending from Customer c
join Invoice i on i.CustomerId = c.CustomerId
group by c.CustomerId;

select * from View_Customer_Spending;

drop view View_Customer_Spending;

-- 5
create index idx_Employee_LastName on Employee(LastName);
select * from Employee where LastName = 'King';
explain select * from Employee where LastName = 'King';
drop index idx_Employee_LastName on Employee;

-- 6
delimiter &&
create procedure GetTracksByGenre(GenreId int)
begin 
	select t.TrackId, t.name as Track_Name, a.title as Album_Title, ar.name as Artist_Name from track t
    join album a on a.AlbumId = t.AlbumId
    join artist ar on ar.ArtistId = a.ArtistId
    where t.GenreId = 1;
end &&
delimiter ;

call GetTracksByGenre(1);

drop procedure GetTracksByGenre;

-- 7
delimiter &&
create procedure GetTrackCountByAlbum(p_AlbumId int)
begin 
	select count(t.TrackId)as Total_Tracks from album a
    join track t on t.AlbumId = a.AlbumId
    where a.AlbumId = p_AlbumId;
end &&
delimiter ;

call GetTrackCountByAlbum(1);

drop procedure GetTrackCountByAlbum;

-- 8) Xóa tất cả các view, procedure và index vừa mới khởi tạo
-- đã xóa ở trong các câu