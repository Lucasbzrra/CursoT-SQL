-- RESTORE filelistonly
-- from DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\crm.bak'

-- RESTORE database crm 
-- from DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\crm.bak'
-- WITH move 'crm ' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\crm.MDF',
-- move 'crm_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\crm_log.LDF'


-- select c.primeiro_nome,
--        c.ultimo_nome,
--        c.nascimento
-- from cliente c
-- where c.sexo = 'female'
-- and c.nascimento BETWEEN '1999-01-03' and '1999-06-1';

-- select * from cliente as a 
-- where a.id_cliente in ('91', '200')

-- select * from cliente as a 
-- where a.id_cliente not in ('168', '200')
-- and (a.etnia) in ('eskimo')

-- use 
-- AdventureWorks2017
-- GO

-- ---Estrutura com exists

-- select P.Firstname,
--        P.LastName
-- from Person.Person as P
-- where exists 
--             (select * 
--                 from HumanResources.Employee as h 
--                     where P.BusinessEntityID = h.BusinessEntityID
--                     and P.LastName = 'johnson');


-- --Outra forma utilizando com IN
-- select P.Firstname,
--        P.LastName
-- from Person.Person as P 
-- where P.LastName in
--             (select P.LastName
--                 from HumanResources.Employee as h 
--                     where P.BusinessEntityID = h.BusinessEntityID
--                     and P.LastName = 'johnson');

--Retornando dados iguais nome do vendedor e de loja
-- select distinct s.name
-- from Sales.Store as s 
-- where exists (
--     select * from Purchasing.Vendor  as v 
--     WHERE s.Name = v.Name)


-- use curso 
-- go


-- select s.uf,
--     count(cod_mun) as qntslinhas 
-- from senso  as s
-- group by s.uf having count(s.cod_mun)>100
-- order by 2 desc

-- SELECT s.uf,
--     sum(s.populacao) as total 
--     from senso as s
--     GROUP by s.uf having SUM(s.populacao)<1000000
--     ORDER by 1 desc