# create a database
create database affiliates;
use affiliates;

# drop database/delete
# drop database affiliates;

# create a table called employees,id,name,department
create table employees (
employee_id int,
name varchar(100),
department varchar(100));

# populate the table
insert into employees (employee_id,name,department)
values
(001,"Annex","Geography"),
(002,"Peter","Physics"),
(003,"Jane","English");

# retrieve some data from the table
select * from employees;
select name from employees;

# ammend the table-add a column for age
alter table employees 
add column age int;

# updating values
update employees
set age = 23
where employee_id = 001;

# set update safe to off
set SQL_SAFE_UPDATES = 0;

# drop the table,entry,column,database