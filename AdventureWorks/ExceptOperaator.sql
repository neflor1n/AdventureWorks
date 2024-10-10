--Loo tabel 

create table TableA (
Id int primary key, 
Name nvarchar(50),
Gender nvarchar(10));
Go

--Lisa andmed tabelis 'TableA'
insert into TableA values(1, 'Mark', 'Male')
insert into TableA values(2, 'Mary', 'Female')
insert into TableA values(3, 'Steve', 'Male')
insert into TableA values(4, 'John', 'Male')
insert into TableA values(5, 'Sara', 'Female')
go

--Loo tabel TableB
create table TableB (
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10)
);
go

--Lisa andmeid 
insert into TableB values(4, 'John', 'Male')
insert into TableB values(5, 'Sara', 'Female')
insert into TableB values(6, 'Pam', 'Female')
insert into TableB values(7, 'Rebeka', 'Female')
insert into TableB values(8, 'Jordan', 'Male')
go


--Pane tähele, et järgnev rida tagastab unikaalse ridade arvu vasakust tabelist, mida ei ole paremas tabelis.
select Id, Name, Gender from TableA
except
select Id, Name, Gender
from TableB


-- Lisa tabel tblEmplooyes 
create table tblEmployees (
Id int identity primary key,
Name nvarchar(100),
Gender nvarchar(10),
Salary int)

--Lisa andmeid
insert into tblEmployees values('Mark', 'Male', 52000)
insert into tblEmployees values('Mary', 'Female', 55000)
insert into tblEmployees values('Steve', 'Male', 45000)
insert into tblEmployees values('John', 'Male', 40000)
insert into tblEmployees values('Sara', 'Female', 48000)
insert into tblEmployees values('Pam', 'Female', 60000)
insert into tblEmployees values('Tom', 'Male', 58000)
insert into tblEmployees values('George', 'Male', 65000)
insert into tblEmployees values('Tina', 'Female', 67000)
insert into tblEmployees values('Ben', 'Male', 80000)
go

-- Order by nõuet võib kasutada ainult kord peale paremat päringut:
select Id, Name, Gender, Salary
from tblEmployees
Where Salary >= 50000
Except
Select Id, Name, Gender, Salary
from tblEmployees
Where Salary >= 60000
order By Name



go

