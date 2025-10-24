use classicmodels;

# joins, aggregations, groupby

# subqueries ; allow us to break a complex piece of query into manageable steps

# compute intermediate results ; filtering
# customers who made payments above the order average value

select * from payments;

select * from customers;

# calculate the average order value
select avg(amount) as avg_order_value from payments;

select customerNumber, customerName
from customers
where customerNumber in
(select customerNumber
from payments 
group by customerNumber
having sum(amount) > (select avg(amount) as avg_order_value from payments));

select customerNumber
from payments 
group by customerNumber
having sum(amount) > (select avg(amount) as avg_order_value from payments);

# Views ; virtual table. reusable query
# a view of order summary
# customer name, order number, order date, total value of the order by
# customers table, orders table (order date, order number), order details (order no., quantity ordered, priceEach)
# orderNumber, orderdate, customername, total value

create view order_summary as
select o.orderNumber, o.orderDate, c.customerName, sum(od.quantityOrdered * od.priceEach) as order_total
from orders o
join orderdetails od on o.orderNumber = od.orderNumber
join customers c on o.customerNumber = c.customerNumber
group by o.orderNumber;

# query the view
select * from order_summary
where order_total > 15000;

# functions ; user defined functions
# is a single value

#create function ...name(parameters)
#return data type
#characteristics - optional ; describes the functions behaviour (deterministic & non deterministic) , time now(), customerNumber ; total
# order value # cache
#begin .....
# return value
#end

select * from payments;

delimiter //
create function total_payments(my_input int)
returns decimal(10,2)
deterministic
begin
	declare total decimal(10,2);
    select sum(amount)
    into total
    from payments
    where customerNumber = my_input;
    return total;
end;
//
delimiter ;

select * from customers;

select customerName, total_payments(customerNumber) as total_payment
from customers;

total_payments(103);

# customer id,
# fetch it from another table ; 5th order

# stored procedures
# on delete ; triggers
