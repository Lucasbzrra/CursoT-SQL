-- select * from senso
-- where uf <> 'SP' 
--  ORDER by uf desc

--  select * from senso
--  where populacao<10000000
--     and populacao>=500
--     and uf ='SP'
--     and nome_mun <> 'VINHEDO' 

-- USE AdventureWorks2017
-- go
-- select p.FIRSTName,
--        p.lastname,
--        e.vacationhours,
--        e.sickleavehours,
--        e.vacationhours + e.sickleavehours as 'horas ausentes'
--        FROM HumanResources.Employee as e
--        join Person.Person as p
--        on p.BusinessEntityID = e.BusinessEntityID
--        order by 'horas ausentes' asc;

-- SELECT * from Sales.SalesTaxRate

-- SELECT MAX(Taxrate),
--        MIN(Taxrate),
--        MAX(Taxrate)-MIN(Taxrate) as 'diferença taxa'
-- from Sales.SalesTaxRate
--  WHERE StateProvinceID is not NULL


-- select * from Production.Product

-- SELECT name,
--        ListPrice,
--        ListPrice * 1,50 as 'novo preco'
--        FROM Production.Product
-- where Name like '%Mountain%'
-- ORDER by ProductID ASC


-- SELECT s.BusinessEntityID as SalesPersonID,
--         p.FIRSTname,
--         p.lastname,
--         s.SalesQuota,
--         s.SalesQuota/12 as 'quota mensal',
--         e.jobtitle
--         from Sales.SalesPerson as s
--         join HumanResources.Employee as e
--         on s.BusinessEntityID = e.BusinessEntityID
--         join Person.Person as p
--         on e.BusinessEntityID=p.BusinessEntityID
-- WHERE s.SalesQuota is not null