use sakila;
-- 2
create view view_long_action_movies as
select f.film_id, f.title, f.length, c.name as category_name
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action' and f.length > 100;

select * from view_long_action_movies;

drop view view_long_action_movies;

-- 3 
create view view_texas_customers as
select c.customer_id, c.first_name, c.last_name, ct.city
from customer c
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join rental r on c.customer_id = r.customer_id
where a.district = 'Texas'
group by c.customer_id;

select * from view_texas_customers;

drop view view_texas_customers;

-- 4
create view view_high_value_staff as
select s.staff_id, s.first_name, s.last_name, sum(p.amount) as total_payment
from staff s
join payment p on s.staff_id = p.staff_id
group by s.staff_id
having total_payment > 100;

select * from view_high_value_staff;

drop view view_high_value_staff;

-- 5
create fulltext index idx_film_title_description on film(title, description);
drop index idx_film_title_description on film;

-- 6
create index idx_rental_inventory_id on rental(inventory_id) using hash;
drop index idx_rental_inventory_id on rental;

-- 7
select * from view_long_action_movies vl
join film f on vl.film_id = f.film_id
where match(f.title, f.description) against ('War');

-- 8
delimiter &&
create procedure get_rental_by_inventory(in inventory_id int)
begin
    select rental_id, rental_date, inventory_id, customer_id, return_date, staff_id
    from rental
    where inventory_id = inventory_id;
end &&
delimiter ;

call get_rental_by_inventory(5);

drop procedure get_rental_by_inventory;

-- 9 da xoa