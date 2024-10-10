--�pilane teeb p�ringu ja n�itab koodi kirja ning tulemust pildi kujul.
--Loo tabel
create table Sales (
Product nvarchar(50),
SaleAmount int
)
Go

--Lisa andmeid
insert into Sales values('iPhone', 500)
insert into Sales values('Laptop', 800)
insert into Sales values('iPhone', 1000)
insert into Sales values('Sneakers', 400)
insert into Sales values('Laptop', 600)

--Selleks, et arvutada kogu m��ki toote pealt, siis peame kirjutama GROUP BY p�ringu:
select Product, Sum(SaleAmount) as totalSales
from Sales
Group by Product




--Kui kasutame WHERE klasulit HAVING-u asemel, siis saame s�ntaksivea.
--P�hjuseks on WHERE-i mitte t��tamine kokku arvutava funktsiooniga, mis sisaldab SUM, MIN, MAX, AVG jne.
select Product, Sum(SaleAmount) as totalSales
from Sales
group by Product
Where sum(SaleAmount) >	1000


--Kalkuleeri iPhone-i ja Speakerite m��ki ja kasuta selleks HAVING klauslit. 
--See n�ide p�rib k�ik read Sales tabelis, mis n�itavad summat ning eemaldavad k�ik tooted peale iPhone-i ja Speakerite.
Select Product, Sum(SaleAmount) as totalSales
from Sales
where Product in ('iPhone', 'Sneakers')
group by Product


--Kalkuleeri iPhone-i ja Speakerite m��ki ja kasutad selleks HAVING klauslit.
--See n�ide p�rib k�ik read Sales tabelis, mis n�itavad summat ning eemaldavad k�ik tooted peale iPhone-i ja Speakerite.

select Product, Sum(SaleAmount) as totalSales
from Sales
group by Product
having Product in ('iPhone', 'Sneakers')
