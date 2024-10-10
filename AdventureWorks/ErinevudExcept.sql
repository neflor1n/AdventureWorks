-- Järgnev päring tagastab read vasakust päringust, mis ei ole paremas tabelis
Select Id, Name, Gender
from TableA
except 
select Id, Name, Gender from TableB

--Sama tulemuse võib saavutada NOT IN operaatoriga:
Select Id, Name, Gender from TableA
where Id not in (Select Id from TableB)

--Except filtreerib korduvaid andmeid ja tagastab ainult erinevaid ridu vasakust päringust, mis ei ole parema rea päringu tulemuses. NOT IN ei filtreeri duplikaate.
--Sisesta järgnev rida tabelisse TableA
insert TableA values(1, 'Mark', 'Male')

--Nüüd käivita NOT IN operaatoriga kood:
--Õpilane teeb päringu ja näitab koodi kirja ning tulemust pildi kujul.
Select Id, Name, Gender from TableA
Where Id not in (Select Id from TableB)


--Järgnevas päringus alampäring tagastab mitu veergu:
select Id, Name, Gender from TableA
Where Id not in (select Id, Name from TableB)
