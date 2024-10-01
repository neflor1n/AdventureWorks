--35 indexid

-- N��d loome indeksi, mis aitab p�ringut: Loome indeksi Salary veerule.
create Index IX_dimEmployee_Salary
ON dimEmployee (BaseRate ASC)

--Kui soovid vaadata Indeksit: Object Exploreris laienda Indexes kausta. 
--Alternatiiviks kasuta sp_helptext-i s�steemi SP-de jaoks. J�rgnev p�ring tagastab k�ik indeksid tblEmployee tabelis.

exec sp_help dimEmployee
--Kui soovid kustutada indeksit: Kui kustutad indeksi, siis t�psusta tabeli nimi.
drop Index dimEmployee.IX_dimEmployee_Salary

--36 indexid
--Selle tulemusel SQL server ei luba luua rohkem, kui �hte klastreeritud indeksit tabeli kohta.  
create clustered Index IX_tblEmployee_Name
ON DimEmployee(FirstName)
-- N��d loome klastreeritud indeksi kahe veeruga. Selleks peame enne kustutama praeguse klastreeritud indeksi Id veerus:
drop index tblEmployee.PK__tblEmplo__3214EC070A9D95DB

select * from DimEmployee
-- N��d k�ivita j�rgnev kood uue klastreeritud �hendindeksi loomiseks Gender ja Salary veeru p�hjal:
CREATE CLUSTERED Index IX_tblEmployee_Gender_Salary
ON DimEmployee (Gender DESC, Salary ASC)

-- Indeksis ise on andmed s�ilitatud laskuvas v�i t�usvas j�rjestuses, mis ei m�juta tabeli salvestuskohas olevaid andmeid.
create NONclustered index IX_tblEmployee_Name
on DimEmployee(FirstName)

-- 37 Unikaalne ja mitte-unikalne indexid

--Loome tabeli Employee, kui seda ei ole loodud:
create table [tblEmployee]
(
[Id] int Primary Key,
[FirstName] nvarchar(50),
[LastName] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(50)
)

--Loome tabeli Employee, kui seda ei ole loodud:
execute sp_helpindex tblEmployee


-- N��d proovime sisestada duplikaatv��rtust Id veergu ja veateadet ei n�e.
insert into tblEmployee values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into tblEmployee values(2, 'John', 'Menco', 2500, 'Male', 'London')

drop index tblEmployee.PK__tblEmplo__3214EC07236943A5


--Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru p�hjal.
CREATE unique nonclustered index UIX_tblEmployee_FirstName_LastName
on tblEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal. Selle t�estuseks lisame koodiga unikaalse piirangu City veerule.


ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

EXECUTE SP_HELPCONSTRAINT tblEmployee

--Vaikimisi korduvaid v��rtuseid ei ole veerus lubatud, kui peaks olema unikaalne indeks v�i piirang.
--Nt, kui tahad sisestada k�mme rida andmeid, millest viis sisaldavad korduvaid andmeid, siis k�ik k�mme l�katakse tagasi.
--Kui soovin ainult viie rea tagasi l�kkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY


-- 38 indeksi plussid ja miinused

create nonclustered index IX_tblEmployee_Salary
on tblEmployee(Salary Asc)

-- J�rgnev SELECT p�ring saab kasu Salary veeru indeksist kuna palgad on indeksis langevas j�rjestuses. 
--Indeksist l�htuvalt on kergem �les otsida palkasid, mis j��vad vahemikku 4000 kuni 8000 ning kasutada reaaadressi.

select * from tblEmployee where Salary > 4000 and Salary < 8000

-- Mitte ainult SELECT k�sklus, vaid isegi DELETE ja UPDATE v�ljendid saavad indeksist kasu.
--Kui soovid uuendada v�i kustutada rida, siis SQL server peab esmalt leidma rea ja indeks saab aidata seda otsingut kiirendada

delete from tblEmployee WHERE Salary = 2500
update tblEmployee Set Salary = 9000 where Salary = 7500

-- Mitte ainult SELECT k�sklus, vaid isegi DELETE ja UPDATE v�ljendid saavad indeksist kasu. 
--Kui soovid uuendada v�i kustutada rida, siis SQL server peab esmalt leidma rea ja indeks saab aidata seda otsingut kiirendada


select * from tblEmployee order by Salary

--Salary veeru indeks saab aidata ka allpool olevat p�ringut. Seda tehakse indeksi tagurpidi skanneerimises.

select * from tblEmployee order by Salary Desc


--GROUP BY p�ringud saavad kasu indeksitest. Kui soovid grupeerida t��tajaid sama palgaga, siis p�ringumootor saab kasutada Salary veeru indeksit, et saada juba sorteeritud palkasid.
--Kuna j�rjestikuses registrikirjes on vastavaid palku, siis tuleb kiiresti lugeda t��tajate koguarv igal palgal.


select Salary, count(Salary) as Total
from tblEmployee
group by Salary



