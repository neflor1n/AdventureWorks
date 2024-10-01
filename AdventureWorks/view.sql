-- 39 view SQL Serveris

-- Skript tblDepartment loomiseks:
Create table tblDepartment(
DeptId int primary key,
DeptName nvarchar(20))
--Skript loomaks tblEmployee table:
create table tblEmloyee (
Id int Primary key,
Name nvarchar(30),
Salary int,
Gender nvarchar(10),
Department int)

-- Andmete sisestamine:
select * from tblDepartment
insert into tblDepartment values (1, 'IT')
insert into tblDepartment values (2, 'Payroll')
insert into tblDepartment values (3, 'HR')
insert into tblDepartment values (4, 'Admin')
insert into tblEmloyee values (1, 'John', 5000, 'Male', 3)
insert into tblEmloyee values (2, 'Mike', 3400, 'Male', 2)
insert into tblEmloyee values (3, 'Pam', 6000, 'Female', 1)
insert into tblEmloyee values (4, 'Todd', 4800, 'Male', 4)
insert into tblEmloyee values (5, 'Sara', 3200, 'Female', 1)
insert into tblEmloyee values (6, 'Sara', 4800, 'Male', 3)

select * from tblEmloyee


-- Selleks, et saada soovitud tulemus, me peaksime �hendama kaks tabelit omavahel. Kui JOIN-d on sulle uus teema, siis vaata eelnevaid harjutusi JOIN-de kohta.

select Id, Name, Salary, Gender, DeptName
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId


--N��d loome view, kus kasutame JOIN-i:

create view vWEmployeesByDepartment
as
Select Id, Name, Salary, Gender, DeptName
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId

--Kui soovime n�ha andmeid l�bi view, siis selleks saab kasutada SELECT k�sklust:


select * from vWEmployeesByDepartment

--View, mis tagastab ainult IT osakonna t��tajad:

create view vWITDepatment_Employees
as
select Id, Name, Salary, Gender, DeptName
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId
where tblDepartment.DeptName = 'IT'


-- View, kus ei ole Salary veergu:

create view vWEmployeesNonConfidentialData
as 
Select Id, Name, Salary, Gender, DeptName
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId


-- Kui soovime n�ha andmeid l�bi view, siis selleks saab kasutada SELECT k�sklust:

-- . View-d saab kasutada esitlemaks ainult koondandmeid ja peitma �ksikasjalikke andmeid.
--View, mis tagastab summeeritud andmed t��tajate koondarvest.

create view vWEmployeesCountByDepartment
as
select DeptName, count(Id) as TotalEmployees
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId
group by DeptName

-- 40 View uuendused
-- Teeme View, mis tagastab peaaegu k�ik veerud, aga va Salary veerg.
create view vWEmployeesDataExceptSalary
as
Select Id, Name, Gender, Department
from tblEmloyee

-- N��d p�ri andmed l�bi view:

select * from vWEmployeesDataExceptSalary

--J�rgnev p�ring uuendab Name veerus olevat nime Mike Mikey peale. Uuendame view-d
--, aga SQL server uuendab tblEmployee tabelis olevat infot. Selleks peab kasutama SELECT v�ljendit:


update vWEmployeesDataExceptSalary
set Name = 'Mikey' where Id = 2

--Samas on v�imalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.

delete from vWEmployeesDataExceptSalary where Id = 2
INSERT into vWEmployeesDataExceptSalary values(2, 'Mikey', 'Male', 2)


--Kood selle loomiseks: 

create view vwEmployeeDetailsByDepartment
as
Select Id, Name, Salary, Gender, DeptName
from tblEmloyee
join tblDepartment
on tblEmloyee.Department = tblDepartment.DeptId

--Tee p�ring ja peaksid n�gema tulemust, mis on v�lja toodud �leval pildil:

select * from vwEmployeeDetailsByDepartment

-- N��d uuendame John osakonda HR pealt IT peale. Hetkel on kaks t��tajat HR osakonnas.
--Kood:

update vwEmployeeDetailsByDepartment
set DeptName = 'IT' where Name = 'John'


