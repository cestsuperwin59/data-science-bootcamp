.open restaurant.db

--table 1 menus------
drop table menus;

  create table menus (
	menu_id int,
	menu_name text,
  menu_price real
);

insert into menus values
	(1, 'Fried_rice', 59.9),
	(2, 'Krapao', 45.9),
  (3, 'Springroll', 30.9),
  (4, 'Chicken_curry', 45.9),
  (5, 'Tom_yam_kung', 60.9);

--table 2 customers-------
drop table customers;

create table customers (
	customer_id int,
	customer_name text,
  customer_surname text,
  customer_phone_number text
);
insert into customers values
	(1, 'Coco', 'Jeanpaul', '5421259'),
	(2, 'Mali', 'Jaidee', '4154591'),
  (3, 'Yajai', 'Sun', '6414285'),
  (4, 'Paul', 'Frank', '7491926'),
  (5, 'Bjorn', 'Speilberg', '9414295'),
  (6, 'Abiola', 'Olaitan', '8889991'),
  (7, 'Sunny', 'Moon', '2456451'),
  (8, 'Teresa', 'Cimmino', '6661456'),
  (9, 'Omega', 'Laurary', '9991928');

--table 3 orders-------
drop table orders;

create table orders (
	order_id int,
	order_customer_id int,
  order_menu_id int,
  order_menu_quantity int,
  order_date text,
  order_branch_id int
);

insert into orders values
  (1, 1, 2, 2, '2023-01-22', 1),
  (1, 1, 1, 5, '2023-01-22', 1),
  (2, 2, 1, 1, '2023-01-22', 1),
  (2, 2, 2, 1, '2023-01-22', 2),
  (3, 8, 4, 1, '2023-01-22', 2),
  (4, 9, 4, 1, '2023-01-22', 1),
  (5, 6, 4, 1, '2023-01-22', 3),
  (5, 6, 2, 2, '2023-01-22', 3);

--table 4 branch-------
drop table branch;

create table branch (
  branch_id int,
  branch_name text
);

insert into branch values
  (1, 'oslo'),
  (2, 'lillestrøm')
  (3, 'Bærum');

--table 5 employees--------
drop table employees;

create table employees (
  employees_id int,  
  employees_name text,
  salary int,
  branch_id int 
);

insert into employees values
  (1,'Apple',1000,1),
  (2,'Martin',1500,1),
  (3,'Luther',1000,2),
  (4,'Ole',1500,2),
  (5,'First',1000,3),
  (6,'Mark',1500,3);

.mode column
.header on

select * from menus;
select * from customers;
select * from orders;
select * from branch;
select * from employees;


--query 1 -- Menus sale
select
  orders.order_menu_id AS sale_menus,
  menus.menu_name AS menu_name,
  menus.menu_price AS menu_price,
  SUM(orders.order_menu_quantity) AS quantity,
  orders.order_menu_quantity*menus.menu_price AS sale
from orders
join menus on menus.menu_id = orders.order_menu_id
group by menu_id;

--query 2 -- Total income each branch
select
  orders.order_branch_id AS branch_id,
  SUM(orders.order_menu_quantity*menus.menu_price) AS sale
from orders
join menus on menus.menu_id = orders.order_menu_id
group by branch_id;

--query 3 --income per invoice (subqueries)
select * from (
  select
    orders.order_id AS invoiceID,
    orders.order_customer_id,
    SUM(orders.order_menu_quantity*menus.menu_price) AS sale
  from orders
  join menus on menus.menu_id = orders.order_menu_id
  group by invoiceID
)
group by order_customer_id
order by invoiceID;

--query 4 -- pay to staff by branch
select 
  employees.branch_id AS branch_id,
  SUM(employees.salary) AS salary_paid
  
  from employees
  group by branch_id;

--query 5 -- top customers
with sub AS (
    select
    orders.order_id AS order_id,
    orders.order_customer_id AS customersID,
    customers.customer_name AS customerName,
    customers.customer_phone_number AS customer_phone,
    sum(orders.order_menu_quantity*menus.menu_price) AS total_sale
    from orders
    join menus on menus.menu_id = orders.order_menu_id
    join customers on customers.customer_id = orders.order_customer_id
    group by order_id
) 
select customersID, customerName, customer_phone, total_sale
  from sub
  order by total_sale desc;


  







