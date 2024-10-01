-- 92. DDL trigger SQL Serveris

create trigger trMyFirstTrigger
on database
for create_table
as
begin
print 'new table created'
end


--kontrollime 
create table Test(id int)
create table Test2(id int)
--�levapool olev trigger k�ivitatakse ainult �he DDL tegevuse juures CREATE_TABLE.
--Kui soovid, et see trigger k�ivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda s�ndmused ning kasuta koma.
Alter trigger trMyFirstTrigger
on database 
for create_table, alter_table, drop_table
as
begin
print 'A table has just been created, modified or deleted'
end

--N��d vaatame n�idet, kuidas �ra hoida kasutajatel loomaks, muutmaks v�i kustatamiseks tabelit. Selleks pead olemasolevat triggerit muutma:

alter trigger trMyFirstTrigger
on database 
for create_table, alter_table, drop_table 
as
begin
rollback
print 'You cannot create, alter or drop a table'
end


-- Saab teha ka SQL koodiga:
disable trigger trMyFirstTrigger on database

enable trigger trMyFirstTrigger on database

--Saab kasutada ka SQL k�sklust:

drop trigger trMyFirstTrigger on database

create trigger trRenameTable
on database
for rename
as
begin
print 'You just renamed something'
end

--kontrollime
create table TestTable(id int)
exec sp_rename 'TestTable', 'NewTestTable';

select * from TestTable
--Invalid object name 'TestTable'.
select * from NewTestTable
--T��tab


-- 93. Server-scoped DDL Triggerid

--K�sitletav trigger on andmebaasi vahemikus olev trigger. See ei luba luua, muuta ja kustutada tabeleid andmebaasist sinna, kuhu see on loodud.

create trigger tr_DatabaseScopeTrigger
on database
for create_table, alter_table, drop_table
as
begin
rollback
print 'You cannot create, alter or drop a table in the current database'
end


drop table NewTestTable


--Loo Serveri-vahemikus olev DDL trigger: See on nagu andembaasi vahemiku trigger, aga erinevus seisneb, et sa pead lisama koodis s�na ALL peale:

create trigger tr_ServerScopeTrigger
on database
for create_table, alter_table, drop_table
as
begin
rollback
print 'U cannot create, alter or drop any table in any database on the server!'
end



disable trigger tr_ServerScopeTrigger on all server
enable trigger tr_ServerScopeTrigger on all server

drop trigger tr_ServerScopeTrigger on all server