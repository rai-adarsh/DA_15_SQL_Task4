create table orders (
    order_id INT primary key,
    order_date DATE,
    customer_id INT,
    order_status VARCHAR(20)
);

insert into orders (order_id, order_date, customer_id, order_status) values
(1, '2025-01-15', 101, 'Pending'),
(2, '2025-01-16', 102, 'Processing'),
(3, '2025-01-17', 103, 'Completed'),
(4, '2025-01-18', 104, 'Cancelled');


-- Step 1: Create ENUM type
create type order_status_enum as enum ('Pending', 'Processing', 'Completed', 'Cancelled');

-- Step 2: Alter table to use ENUM type
alter table orders
alter column order_status type order_status_enum
using order_status::order_status_enum;


---create a conditional query with enum type

select * from orders;

--- conditional query on string values
select *,
case
when order_status in('Pending', 'Processing')then 'Active'
else 'Inactive'
end as order_activity_status
from orders;

---conditional query on int/float values

alter table orders 
add column sales float;

alter table orders 
add column no_of_qty int;

select * from orders;

begin;

update orders set
 sales =case 
when order_id = 1 then 255.6
when order_id = 2 then 1565.22
when order_id = 3 then 451.5
when order_id = 4 then 877.9
end,
no_of_qty = case 
when order_id = 1 then 2
when order_id = 2 then 1
when order_id = 3 then 4
when order_id = 4 then 11
end
where order_id in (1, 2, 3, 4);


rollback;

create type math_type as enum ('sum', 'add', 'mul', 'div');

begin;

--- create function
create or replace function basic_op(op math_type, sales float , no_of_qty int)
returns float as $$
DECLARE sumdata float;
BEGIN
if op = 'mul' THEN sumdata =sales * no_of_qty;
elseif op= 'div' THEN sumdata= sales/no_of_qty;
else sumdata = sales+no_of_qty;
end if;
return  sumdata;
END;
$$ LANGUAGE plpgsql

select * , basic_op('mul',sales, no_of_qty) from orders ;

select * , basic_op('div',sales, no_of_qty) from orders ;

commit;

