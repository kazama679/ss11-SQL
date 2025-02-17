use sakila;

-- 2
create unique index idx_unique_email 
on customer(email);

insert into customer (store_id, first_name, last_name, email, address_id, active, create_date)
values (1, 'Jane', 'Doe', 'johndoe@example.com', 6, 1, now());

-- 3
delimiter //
create procedure CheckCustomerEmail(in email_input varchar(50), out exists_flag int)
begin
    select count(*) into exists_flag 
    from customer 
    where email = email_input;
end;
//
delimiter ;

call CheckCustomerEmail('johndoe@example.com', @exists_flag);
select @exists_flag;

-- 4
create index idx_rental_customer_id 
on rental(customer_id);

-- 5
create view view_active_customer_rentals as
select c.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, r.rental_date, 
    case 
        when r.return_date is not null then 'Returned' 
        else 'Not Returned' 
    end as status
from customer c
join rental r on c.customer_id = r.customer_id
where c.active = 1 and r.rental_date >= '2023-01-01'
and (r.return_date is null or r.return_date >= date_sub(curdate(), interval 30 day));

-- 6
create index idx_payment_customer_id 
on payment(customer_id);

-- 7
create view view_customer_payments as
select c.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, sum(p.amount) as total_payment
from customer c
join payment p on c.customer_id = p.customer_id
where p.payment_date >= '2023-01-01'
group by c.customer_id, c.first_name, c.last_name
having total_payment > 100;

-- 8
delimiter //
create procedure GetCustomerPaymentsByAmount(in min_amount decimal(10,2), in date_from date)
begin
    select * 
    from view_customer_payments 
    where total_payment >= min_amount and payment_date >= date_from;
end;
//
delimiter ;

call GetCustomerPaymentsByAmount(150, '2023-01-01');

-- 9
drop view if exists view_active_customer_rentals;
drop view if exists view_customer_payments;

drop procedure if exists CheckCustomerEmail;
drop procedure if exists GetCustomerPaymentsByAmount;

drop index idx_unique_email on customer;
drop index idx_rental_customer_id on rental;
drop index idx_payment_customer_id on payment;