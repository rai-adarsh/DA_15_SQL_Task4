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


select *,
case
when order_status in('Pending', 'Processing')then 'Active'
else 'Inactive'
end as order_activity_status
from orders;


