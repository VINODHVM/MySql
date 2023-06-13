create database Library;
use Library;

create table Branch(
Branch_no int primary key,
Manager_id int,
Branch_address varchar(100),
Contact_no varchar(15)
);

SELECT * FROM Branch;

insert into Branch values
 (1,21,"Bombay,1St Floor",1123456789),
 (2,22,"Maharashtra,Floor 3",1223456789),
 (3,23,"Jaipur,2nd Floor",1323456789),
 (4,24,"Hambi,3St Floor",1423456789),
 (5,25,"Surat,11th Floor",1523456789);
 
create table Employee(
Emp_id int primary key,
Emp_name varchar(30),
Position varchar(30),
Salary decimal(10,2));

SELECT * FROM Employee;

insert into Employee values
 (21,"Rahul","Sales Man",120000.00),
 (22,"Miya","Accontant",70000.00),
 (23,"Gopu","Manager",150000.00),
 (24,"Maya","Clerk",35000.00),
 (25,"Money","Purchase Mananger",110000.00);

insert into Employee values (26,"Jijo Varghese","Sales Man",130000.00);
 
create table Customer(
Customer_id int primary key,
Customer_name varchar(30),
Customer_Address varchar(50),
Reg_Date date
);

SELECT * FROM Customer;

insert into Customer values
 (10,"Midhun Joseph","Manarcad,Kottayam","2002-06-23"),
 (11,"Boby Kurian","Manganam,Kottayam","2005-06-22"),
 (12,"Jenitha","Manimala,Kottayam","2009-10-22"),
 (13,"Jacob P George","Puthuppallu,Kottayam","1995-03-15"),
 (14,"Rudhra","Vaikom, Kottayam","2009-11-11");

insert into Customer values (15,"Midhun Joseph","Manarcad,Kottayam","2010-07-13");

UPDATE  Customer SET Customer_name = "ROBERT JOSE" WHERE Customer_id = 15;
 
create table Books(
ISBN varchar(30) primary key,
Book_Title varchar(50),
Category varchar(40),
Rental_Price decimal(8,2),
Status enum("yes", "no"),
Author varchar(50),
Publisher varchar(50)
);

SELECT * FROM Books;

insert into Books values
 ("BOOK01","ENGLISH LITERATUR","LITERATUR","10.00","no","ANDREWS","DCC BOOKS"),
 ("BOOK02","MALAYALAM PHILOSAPHY","PHILOSAPHY","20.00","no","SATHEESH CHANDRAN","MALAYA BOOKS"),
 ("BOOK03","SOCIAL SCIENCE","SCIENCE","20.50","yes","MARKO LEWANSKY","SCIENCE PUBLICATION"),
 ("BOOK04","MATHS CALCULATION","MATHS","10.00","yes","GURGIUAF","LOGICAL PUBLICATION"),
 ("BOOK05","HUMAN BIOLOGY","BIOLOGY","10.99","no","JAMES WHAT","BIO MATRICS"); 
 
create table IssueStatus(
Issue_id int primary key,
Issued_Cust int  ,
Issued_Book_Name varchar(60),
Issued_Date date,
Isbn_Book varchar(55),
FOREIGN KEY (Issued_Cust) REFERENCES Customer(Customer_id),
FOREIGN KEY (Isbn_Book) REFERENCES Books(ISBN));

SELECT * FROM IssueStatus;

insert into IssueStatus values
 (1,10,"ENGLISH LITERATUR","2022-01-12","BOOK01"),
 (2,11,"SOCIAL SCIENCE","2020-03-31","BOOK02"),
 (3,12,"MATHS CALCULATION","2019-11-04","BOOK03"),
 (4,13,"HUMAN BIOLOGY","2011-09-21","BOOK04"),
 (5,14,"SOCIAL SCIENCE","2023-12-14","BOOK03");

insert into IssueStatus values (6,13,"MALAYALAM PHILOSAPHY","2023-06-10","BOOK02");
 
 
create table ReturnStatus(
Return_id int primary key,
Return_Cust int,
Return_Book_Name varchar(30),
Return_Date date,
Isbn_Book2 varchar(30),
foreign key (Isbn_Book2) references Books (ISBN)
);
 
 SELECT *  FROM ReturnStatus;
 
insert into ReturnStatus values
 (1,10,"ENGLISH LITERATUR","2022-04-25","BOOK01"),
 (2,11,"SOCIAL SCIENCE","2020-04-10","BOOK03"),
 (3,12,"MATHS CALCULATION","2020-01-12","BOOK03"),
 (4,13,"HUMAN BIOLOGY","2011-12-18","BOOK04"),
 (5,14,"SOCIAL SCIENCE","2024-01-11","BOOK03");
 

 
1.Retrieve the book title, category, and rental price of all available books. ;

select Book_Title,Category,Rental_Price from Books where Status = "yes";

2.List the employee names and their respective salaries in descending;

select Emp_name, Salary from Employee order by Salary desc;

3.Retrieve the book titles and the corresponding customers who have ;

select b.Book_Title, c.Customer_name from IssueStatus i join Books b on i.Isbn_Book = b.ISBN
join Customer c on i.Issued_Cust = c.Customer_id;

4.Display the total count of books in each category.;

select Category, count(*) as Total_Count from Books group by Category;

5.Retrieve the employee names and their positions for the employees
whose salaries are above Rs.50,000. ;

select Emp_name, Position from Employee where Salary>50000;

6.List the customer names who registered before 2022-01-01 and have not issued any books yet.;

select Customer_name
from Customer
where Reg_Date < "2022-01-01" and Customer_id not in (
    select Issued_Cust
    from IssueStatus
);

7.Display the Position numbers and the total count of employees in each Position;

select Position, count(*) as Total_Employees
from Employee
group by Position;

8.Display the names of customers who have issued books in the month
of June 2023. ;

select c.Customer_name
from Customer c
join IssueStatus i on c.Customer_id = i.Issued_Cust
where month(i.Issued_Date) = 6 and year(i.Issued_Date) = 2023;

9.Retrieve book_title from book table containing PHILOSAPHY.;

select Book_Title
from Books
where Category = "PHILOSAPHY";

10. Retrieve the Position numbers along with the count of employees for 
Position having less than 5 employees;

select Position, count(*) as Total_Employees
from Employee
group by Position
having count(*) < 5;