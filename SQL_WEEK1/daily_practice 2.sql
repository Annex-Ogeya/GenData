use classicmodels;

# aliasing columns

select * 
from customers;


select customerNumber as Number,city as City from customers

# wildcards ; like; pattern matching queries
# select records of customers whose customer name start with mini %

select *
from customers
where customerName LIKE "Mini%";

# return record ending with Ltd.
select *
from customers
where customerName LIKE "%Ltd.";

# return nad within the customer name
select *
from customers
Where customerName LIKE "%nad%";

# records that start with c end with d
select *
from customers
where customerName LIKE "c%d";

# match exactly x characters (City) m,4,d
select * from customers
where city LIKE "M____d";

# case sensistivity
select * from customers
where city LIKE binary "%v%"

# aggregation,,max(),min()
select * from payments;
select sum(amount) as Total
from payments;

select count(*) as total_payments,sum(amount) as Total, avg(amount) as average_payments
from payments;

# string functions-length,upercase,lowercase,concat
select lower(contactLastName),upper(contactFirstName) from customers;

select contactFirstName,length(contactFirstName) as length from customers;

select concat(contactLastName," ",contactFirstName) as Full_Name from customers;

# date functions ; year(),month,day,now,between X and Y(a certain timestamp)

# case statement-Shipped,Resolved,Cancelled,On hold,Disputed
select distinct status from orders;
select * ,
	case
		when status = "Shipped" then "Order Completed"
        when status = "Resolved" then "Order Completed"
        else "Order Pending"
        end as OrderStatus
from orders;

# JOINS ; inner,full outer,left,right
# table aliasing

# customers ; CustomerName,phone
select * from customers;
#orders ; orderDate,status
select * from orders;

select customers.customerName,customers.phone,orders.orderDate,orders.status
from customers
inner join
orders on customers.customerNumber = orders.customerNumber;

# aliasing
select o.orderDate,o.status,c.customerName,c.phone
from orders o
inner join customers c
on o.customerNumber = c.customerNumber;

select o.orderDate,o.status,c.customerName,c.phone
from orders o
left join customers c
on o.customerNumber = c.customerNumber;

# outerjoin
#union ; left and right joins
select o.orderDate,o.status,c.customerName,c.phone
from orders o
left join customers c on o.customerNumber = c.customerNumber
union
select o.orderDate,o.status,c.customerNumber,c.phone
from orders o
right join customers c on o.customerNumber = c.customerNumber;

# groupby
# total value of all orders placed by each customer
# identify your core tables ; customers
# orders table ; orderNuber + customerNumber
# order details ; orderNumber + priceEach
# customers to orders to order details
select * from orderdetails limit 5;

select c.customerName as Name, sum(od.quantityOrdered * od.priceEach) as Total_Order_Value
from customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
group by c.customerName;

        

