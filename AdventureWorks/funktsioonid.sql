use AdventureWorksDW2019

--32 funktsioonid

-- Tabelisisev��rtusega funktsioon e Inline Table Valued function (ILTVF) koodin�ide:

Create Function fn_ILTVF_dimEmployee()
Returns Table 
as
Return (Select EmployeeKey, FirstName, Cast(BirthDate as Date) as DOB
From dimEmployee)

Select * from fn_ILTVF_dimEmployee()

--Tabelisisev��rtusega funktsioon e Inline Table Valued function (ILTVF) koodin�ide:
Create Function fn_MSTVF_getEmployees()
Returns @Table Table (EmployeeKey int, FirstName nvarchar(20), DOB Date)
as
Begin
Insert into @Table
Select EmployeeKey, FirstName, Cast(BirthDate as Date)
From dimEmployee
Return
end

-- Kui n��d soovid m�lemat funktsiooni esile kutsuda, siis kasutad koodi:
Select * from fn_ILTVF_dimEmployee()
Select * from fn_MSTVF_GetEmployees()

-- See p�ring uuendab Sam-i Sam1 peale tblEmployee allasuvas tabelis.
--Kui proovid seda teha MSTVF funktsiooniga, siis saad veateate 'Object 'fn_MSTVF_GetEmployees' cannot be modified.'.
update fn_ILTVF_dimEmployee() set FirstName = 'Sam1' where EmployeeKey = 1;

-- 33 funktsioonid


-- Skaleeritav funktsioon ilma kr�pteerimata:
create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as
begin
return (select Name from dimEployee where Id = @Id)
end


-- N��d muudame funktsiooni ja kr�pteerime selle �ra:

USE [AdventureWorksDW2019]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetEmployeeNameById]    Script Date: 26.09.2024 10:45:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[fn_GetEmployeeNameById](@EmployeeKey int)
Returns nvarchar(20)
With Encryption
as
Begin
Return (Select FirstName from dbo.DimEmployee Where EmployeeKey = @EmployeeKey)
End


