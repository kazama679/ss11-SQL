use sakila;

-- 3
create view view_film_category as 
select f.film_id, f.title, c.name as category_name from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id;

select * from view_film_category;

drop view view_film_category;

-- 4
create view view_high_value_customers as 
select c.customer_id, c.first_name, c.last_name, sum(p.amount) as total_payment from customer c
join payment p on p.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
having total_payment > 100;

select * from view_high_value_customers;

drop view view_high_value_customers;

-- 5
create index idx_rental_rental_date on rental(rental_date);

select * 
from rental 
where rental_date = '2005-06-14';

explain select * 
from rental 
where rental_date = '2005-06-14';

drop index idx_rental_rental_date on rental;

-- 6
delimiter &&
create procedure CountCustomerRentals(customer_id int, out rental_count int)
begin 
	select customer_id, count(r.rental_id) as rental_count from customer c 
    join rental r on r.customer_id = c.customer_id
    where c.customer_id = customer_id;
end &&
delimiter ;

call CountCustomerRentals(1, @rental_count);

drop procedure CountCustomerRentals;

7) Viết một Stored Procedure có tên GetCustomerEmail để trả về email của một khách hàng dựa trên ID khách hàng. Đầu vào (IN parameter): customer_id (ID của khách hàng)
-- 7
delimiter &&
create procedure GetCustomerEmail(customerid int)
begin 
	select customer_id, email from customer
    where customer_id = customerid;
end &&
delimiter ;

call GetCustomerEmail(1);

drop procedure GetCustomerEmail;

-- 8 da xoa