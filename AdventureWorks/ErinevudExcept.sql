-- J�rgnev p�ring tagastab read vasakust p�ringust, mis ei ole paremas tabelis
Select Id, Name, Gender
from TableA
except 
select Id, Name, Gender from TableB

--Sama tulemuse v�ib saavutada NOT IN operaatoriga:
Select Id, Name, Gender from TableA
where Id not in (Select Id from TableB)

--Except filtreerib korduvaid andmeid ja tagastab ainult erinevaid ridu vasakust p�ringust, mis ei ole parema rea p�ringu tulemuses. NOT IN ei filtreeri duplikaate.
--Sisesta j�rgnev rida tabelisse TableA
insert TableA values(1, 'Mark', 'Male')

--N��d k�ivita NOT IN operaatoriga kood:
--�pilane teeb p�ringu ja n�itab koodi kirja ning tulemust pildi kujul.
Select Id, Name, Gender from TableA
Where Id not in (Select Id from TableB)


--J�rgnevas p�ringus alamp�ring tagastab mitu veergu:
select Id, Name, Gender from TableA
Where Id not in (select Id, Name from TableB)
