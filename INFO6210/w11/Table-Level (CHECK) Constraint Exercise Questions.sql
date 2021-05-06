
-- Exercise Question 1

/* Given the following tables, there is a university rule
   preventing a student from enrolling in a new class if there is
   an unpaid fine. Please write a table-level (CHECK) constraint
   to implement the rule. */

create table Course
(CourseID int primary key,
 CourseName varchar(50),
 InstructorID int,
 AcademicYear int,
 Semester smallint);

create table Student
(StudentID int primary key,
 LastName varchar (50),
 FirstName varchar (50),
 Email varchar(30),
 PhoneNumber varchar (20));

create table Enrollment
(CourseID int references Course(CourseID),
 StudentID int references Student(StudentID),
 RegisterDate date,
 primary key (CourseID, StudentID));

create table Fine
(StudentID int references Student(StudentID),
 IssueDate date,
 Amount money,
 PaidDate date
 primary key (StudentID, IssueDate));







 -- Exercise Question 2

 /* Given the following tables, there is a business rule
   preventing a customer from checking out equipment if there is
   an unpaid fine. Please write a table-level constraint
   to implement the business rule. */

create table Equipment
(InventoryID int primary key,
 Name varchar(50),
 CategoryID int);

create table Customer
(CustomerID int primary key,
 LastName varchar (50),
 FirstName varchar (50),
 PhoneNumber varchar (20));

create table CustomerCheckOut
(InventoryID int references Equipment(InventoryID),
 CustomerID int references Customer(CustomerID),
 CheckOutDate date,
 ReturnDate date
 primary key (InventoryID, CustomerID, CheckOutDate));

create table Fine
(CustomerID int references Customer(CustomerID),
 IssueDate date,
 Amount money,
 PaidDate date
 primary key (CustomerID, IssueDate));





