create table customer (
    customer_id serial,
    customer_name varchar(256),
    customer_email char(256),
    customer_address varchar(256),
    customer_contact varchar(256)
);


insert into customer (customer_name, customer_email, customer_address, customer_contact) VALUES
('adarsh rai', 'adarsh.rai@gmail.com', '123 bhatinda', '555-1234'),
('pratik rajput', 'pratik.rajput@yahoo.net', '45 jalandhar', '555-5678');

select * from customer;

--  Create the domain using regex instead of putting values using 'in'
create domain email_domain as varchar(256)
check (value ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');



-- Step 2: Alter the table to use the domain type
alter table customer
alter column customer_email set data type email_domain;
