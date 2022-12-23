-- funções logicas (choose iif)
--choose retorna o item ao ídince especificado de uma lista de valores no sql server 
-- IFF retornar um de dois valores, dependendo de a expressão booliana ser avalidada como true ou false no sql server

select choose(3,'gerente','Ceo','Diretor','QTA') as expressao

use AdventureWorks2017
go 

select ProductCategoryID,
choose(ProductCategoryID,'A','B','C','D') as expressao
from Production.ProductCategory

---exemplo 2

select jobtitle,
       hiredate,
       MONTH(hiredate) mes,
       CHOOSE(MONTH(HireDate),'winter','winter','spring',
                                'spring','summer','summer','summer',
                                'autum','autum','autum','winter') as quarter_hired
       from HumanResources.Employee
       where YEAR(HireDate)>2005
       order by year(HireDate)

-- IFF retornar um de dois valores, dependendo de a expressão booliana ser avalidada como true ou false no sql server
DECLARE @a int =45,
        @b int =50
        select IIF(@a<@b, 'True','False') as result

declare @a int = 45,
        @b int = 40
        select iif(@a>@b, 'maior','menor') as resultado

--USANDO NULOS --FORMA INCORRETA---
select iif(45>30, null,null) as result

--Agora utilizando nulos

declare @a int = 45,
        @b int = 40
        select iif(@a>@b, null,'menor') as resultado

