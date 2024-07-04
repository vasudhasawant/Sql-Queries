use assignment

--1) How to find highest salary from employees table (explain different ways).

create table employees
(
Id int identity,
[First name] varchar(50),
[Last name] varchar(50),
gender varchar(50),
salar int
)
insert into employees values('deepak','godse','male',70000),('puja','bhajibhakare','female',60000),
('kartika','devkar','female',45000),('priyanka','sapkal','female',70000),('kirti','kavle','female',45000),
('suraj','namde','male',30000),('shivaji','garande','male',35000),('shubham','raut','male',8000)

select * from employees
--use subquery
select max(salar)as Highsalary  from employees  where salar >=(select max(salar)from employees)

--use cte
 with cte 
 as
 (
 select id,[First name],[Last name],gender,salar,ROW_NUMBER()
 OVER (ORDER BY salar DESC) AS SalaryRank from employees
 )
 select * from cte where SalaryRank=1

 --use aggrigate function
 select max(salar) as high from employees

 drop table employees
--2)CREATE EMPLOYEE TABLE with EMPLOYEEID, NAME, GENDER, CITY, MOBILE, EMAIL, columns

create table employees
(
employeeid int identity,
name varchar(50),
gender varchar(50),
city varchar(50),
mobile varchar(10),
email varchar(50),
)
insert into employees values('ajay','male','pune','7986290346','ajay@123.com')
insert into employees values('ganesh','male','pune','7843290346','ganesh@123.com')
select * from employees

 --3)write a query to retrieve the list of patients from the same state? 

 create table patients
 (
 patientid int identity,
 patienname varchar(50),
 mobno varchar(10),
 age int,
 city varchar(50),
 state varchar(50),
 )
insert into patients values('anup','9393940592',25,'pune','kerala'),
('vidya','9343940592',25,'pune','kerala'),('reya','9393940592',26,'pune','goa'),
('mayuri','8993940592',25,'pune','kerala'),('gayatri','9393670592',27,'pune','goa'),
('jahavi','9563940592',27,'pune','haryana'),('sakshi','9393350592',28,'pune','kerala'),
('revati','9345494052',28,'pune','haryana'),('divya','9393965052',29,'pune','kerala')

select * from patients where state='goa'

--4)write a query to fetch student name, mobile, email, course name, 
--trainer name, address, batch name, team name

create table student
(
stdid int primary key identity,
stdnm varchar(50) not null,
courseid int,
trainerid int,
batchid int,
mobile varchar(50) unique,
email varchar(30)not null unique,
)
insert into student values('vasudha',2,1,3,'7620631597','vasudha181202@gmail.com'),
('gayatri',1,3,2,'9834974567','gayatrisawat23@gmail.com'),
('pooja',3,2,1,'8010552065','poojanikam23@gmail.com'),
('mansi',1,1,1,'8010952045','mansi99@gmail.com')
create table course
(
courseid int primary key identity,
coursenm varchar(40) not null,
fees int
)
insert into course values('java',80000),('DotNet',50000),('python',30000)
create table trainer
(
trainerid int primary key identity,
trainernm varchar(40),
address varchar(50),
)
insert into trainer values('vikul','katraj'),('usha','pune'),('atul','nashik')
create table batch
(
batchid int identity,
batchname varchar(50),
teamname varchar(50)
)
insert into batch values('batch22','pinkteam'),('batch21','whiteteam'),('batch20','blackteam')

select * from student
select * from trainer
select * from course
select * from batch


select stdnm, mobile, email,coursenm ,trainernm,address,batchname,teamname
from student s join course c
on s.courseid=c.courseid
join trainer t 
on 
s.trainerid=t.trainerid
join batch b
on 
s.batchid=b.batchid

--5) If in my database there are thousands of records already,
--and client required to add some more new columns there then how we can
--provide values to those newly added columns? by update or 
--stored procedures or any other way. 


----step 1 
select * from student
alter table student
add isconform varchar(10)
update student set isconform='yes'

--step 2
use assignment
create procedure procnm
@column varchar(20)out
as
begin
select * from student
alter table student
add gender varchar(50)
end
declare @r3 varchar(50)
execute procnm @column=@r3 out
print @r3

update student set gender='male'
select * from student

---------------------------------6)write a scalar function that return the number of working days between two dates 
 --Working days – Monday to Friday
 --And return year month day


 Create function fnworkingday (
    @StartDate DATE,
    @EndDate DATE
)
returns nvarchar(100)
AS
begin
    declare @WorkingDays INT = 0;
    declare @CurrentDate DATE = @StartDate;

    while @CurrentDate <= @EndDate
    begin
         IF datepart(weekday, @CurrentDate) BETWEEN 2 AND 6
        begin
            set @WorkingDays = @WorkingDays + 1;
        end

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    end
    declare @Years INT, @Months INT, @Days INT;
    select
        @Years = datediff(YEAR, @StartDate, @EndDate),
        @Months = datediff(MONTH, @StartDate, @EndDate) % 12,
        @Days = datediff(DAY, @StartDate, @EndDate) % 30;
    DECLARE @Result NVARCHAR(100);
    SET @Result = 
        CASE 
            WHEN @Years > 0 THEN CAST(@Years AS NVARCHAR(10)) + ' years, '
            ELSE ''
        END +
        CASE 
            WHEN @Months > 0 THEN CAST(@Months AS NVARCHAR(10)) + ' months, '
            ELSE ''
        END +
        CAST(@Days AS NVARCHAR(10)) + ' days';

    RETURN @Result;
END;

DECLARE @StartDate DATE = '2023-01-02'; -- Monday
DECLARE @EndDate DATE = '2023-01-06';   -- Friday

SELECT fnworkingday(@StartDate, @EndDate);
------------------------------------------------------------------------------------------------------------
--7)write a query to fetch student name with paid fees.


create table stude
(
id int primary key identity,
studentnm varchar(50),
class varchar(50) unique
)
insert into stude values('rahul','tybcs'),('ganesh','tybca'),('hemant','tycom')
create table fees
(
id int primary key identity,
class varchar(50) unique,
fees int not null,
)
insert into fees values('tybca',90000),('tybcs',60000),('tycom',50000)

select s.studentnm,f.fees 
from stude s join fees f
on s.class=f.class

---8)write a query to fetch student name, trainer and guide name.

select * from student
select * from trainer
create table guidenm
(
id int identity,
guide varchar(50),
city varchar(50),
stdid int
)

insert into guidenm values('aditya','nashik',2),('rahul','malegon',3),('manish','pune',1)
select * from guidenm

select s.stdnm,t.trainernm,g.guide
from student s join trainer t
on s.trainerid=t.trainerid
join guidenm g
on g.stdid=s.stdid

--9)create a student table with fn, mn, In columns 
-- Create a function fn_FullName which returns full name of student

create table std
(
id int identity,
fn varchar(50),
mn varchar(50),
ln varchar(50)
)

insert into std values('vasudha','hemant','sawant'),('gayatri','shivaji','sawant'),
('pooja','nanaji','nikam'),('mansi','nitin','pawar')


select fn,mn,ln,(fn+' '+mn+' '+ln)as fullname from std

--using function

create function dbo.fn_FullName (@id INT)
returns varchar(100)
as
begin
    declare @FullName varchar(100);

    select @FullName = concat(fn, ' ', mn,' ',ln)
    from Std
    where ID = @ID;

    return @FullName;
end;
select fn,mn,ln,dbo.fn_FullName(id)as FullName from std

--10)I have two tables in one table I have 5 records and another table I have 0 records 
--What will be the output or how many records we will get output if we apply cross join.

select * from std

create table tbvs
(
id int,
name varchar(50),
addd varchar(50)
)

select s.fn as firstname,s.mn as middlenm,v.name as name,v.addd as address
from std s  cross join tbvs v

--when apply the cross join then zero record found in that table

--11)Create table table1 (col1 int) 
--Insert into table1 values (1), (2), (3)
--Create table table2 (col1 int)
--Insert into table2 values (1), (3)
--Can we join these two tables?

Create table table1 (col1 int) 
Insert into table1 values (1), (2), (3)
Create table table2 (col1 int)
Insert into table2 values (1), (3)

select t.col1,r.col1
from table1 t join table2 r
on t.col1=r.col1
--Can we join these two tables?
--ANS:YES,because column datatype is same

--12)Create a student table without any constraints and apply constraints using alter table, create 
--constraints 
--we cannot apply primary key on existing table using alter command

create table Students (
    StudentID int,
    FirstName varchar(50),
    LastName varchar(50),
    Age int
)

select * from students
-- Add a unique constraint to ensure each adharno is unique
alter table Students
add adharno int unique 

-- Add a foreign key constraint to reference a Departments table
alter table Students
add sid int foreign key references trainer(trainerid )

-- Add a check constraint to restrict Age to be greater than or equal to 18
alter table Students
ADD age int CHECK (Age >= 18)


insert into Students values(2,'reya','sawant',65776522,2,22)

--13) How to add multiple records in one database in single query?INSERT INTO student (name, gender, city)values('vasudha','female','Nashik'), ('gayatri','female','Nashik'),
('pooja','female','Nashik'),('mannsi','female','Nashik')

--OR shortcut
INSERT INTO student values('vasudha','female','Nashik'), ('gayatri','female','Nashik'),
('pooja','female','Nashik'),('mannsi','female','Nashik')
                                
--14)explain joins hoe to identify right side table or left side table?
--INNER JOIN: common data from both the table
--LEFT JOIN: common data plus uncommmon data from left table
--RIGHT JOIN: common data plus uncommmon data from right table
--FULL OUTER JOIN: common data plus uncommmon data from both the table
--CROSS JOIN: it return cartesian product

--*use foreign key table as left table
-------------------------------------------------------------------------------------------------------------------
--15)If in case, multiple triggers are present for same condition 
--and on same table then SQL gives priority to which trigger? Are all triggers executed?--------------------------------------------------------------------------------------------------------------------16)6)How we can see non-clustered index table sorting values.