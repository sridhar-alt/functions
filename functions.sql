create table Employee
(
EmployeeId int primary key,
Name varchar(12) not null,
dob date not null,
DepartmentId int foreign key references Department(DepartmentId),
Salary int not null,
)
 create table Department
 (
 DepartmentId int primary key,
 DepartmentName varchar(12) not null
 )

 create view EmployeeView
 as select
 EmployeeId,
 Name,
 dob,
 Salary,
 DepartmentName 
 from Employee 
 join Department 
 on Employee.DepartmentId=Department.DepartmentId

 insert into Department values(104,'Development')
 insert into Department values(105,'Testing')
 insert into Employee values(104,'sri','01-10-1998',101,30000)
 insert into Employee values(105,'hari','02-10-1997',102,40000)


 select * from Employee
 select * from Department
 select * from EmployeeView

 drop table Employee;
 drop table department;
 drop  view EmployeeView;

 create trigger EmployeeTrigger
 on EmployeeView
 Instead of insert
 as
 begin
 Declare @DeptId int
 select @DeptId=DepartmentId 
 from Department join
 inserted on Department.DepartmentName=inserted.DepartmentName
 if(@DeptId is null)
 begin
 Raiserror('Invalid Department name',16,1);
 return
 end
 insert into Employee(EmployeeId,Name,dob,DepartmentId,Salary)
 select i.EmployeeId,Name,dob,@DeptId,Salary from inserted i
 end



--use sample

alter function Cal_age(
@DOB date
)
returns int
as
begin
	return year(GETDATE())-year(@DOB);
end;

	drop function Cal_age

select dbo.Cal_age('02-10-1998')  age;