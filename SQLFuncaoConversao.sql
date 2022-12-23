--Funçoes Matematicas
--ABS Uma função que retorna valor positivo
select abs(-3),
        abs(-1000)

-- Retorna um numero aleatorio 
select abs(rand()),
        RAND()

--Exemplo
declare @cont SMALLINT;
set @cont = 1
while @cont <5
    begin 
        SELECT(RAND())
        set @cont=@cont+1
    END

--Round (retorna um valor numerico, arrendodado, para o comprimento ou precisao especificados)
select ROUND(RAND(),3)

select round(99,0) 
select ROUND(123.454,-1)

--função pontenciada

select POWER(2,10)

select POWER(1,7)

--outra forma

declare @a int=2,
        @b int =10;
select POWER(@a,@b)

--SQRT Raiz quadrada

select SQRT(9)

--Funcoes conervsão
declare @meuvalor decimal(5,2)=193.57
select CAST(@meuvalor as varchar(100))
select CAST(CAST(@meuvalor as varchar ) as decimal )
select CAST(CAST(@meuvalor as varbinary(20) ) as decimal(5,2))

---Utilizando covert 

select convert(varbinary(20), @meuvalor)
select CONVERT(decimal(5,2), CONVERT(varbinary(20), @meuvalor))


use AdventureWorks2017
go
--utilizando substring convert
select SUBSTRING(name,1,30 ) as ProductName, --SUBSTRIGN pega a coluna e indica ate onde deseja ir
listprice 
from Production.Product
where CONVERT(int,listprice) like '3%'


--utilizando substring CAST
select SUBSTRING(name,1,30 ) as ProductName, --SUBSTRIGN pega a coluna e indica ate onde deseja ir
listprice 
from Production.Product
where cast(listprice as varchar) like '3%'


--Formnatando com cast e arrendondando

SELECT top 10.* from Sales.SalesPerson

select cast(ROUND(SalesYTD/CommissionPct, 0 )as int ) as formatado,
                 (SalesYTD/CommissionPct) nãoformatdo
from Sales.SalesPerson
where CommissionPct<>0

--Cast concatenação

--Forma incorreta
select 'A lista do preco' + ListPrice as listapreco
from Production.Product
where ListPrice BETWEEN 350.00 and 400.00

--Forma correta 
select 'A lista do preco' + cast(ListPrice as varchar)
from Production.Product
where ListPrice BETWEEN 350.00 and 400.00

---Cast concatenação com distinct 
select distinct 'A lista do preco ' + CAST(ListPrice as varchar(12)) as listprice
from Production.Product
where ListPrice BETWEEN 250.00 and 350.00

--FUNCOES DE CONVERSÂO PARTE 2

select top(10)* from sales.SalesOrderDetail
select * from Production.Product
where Name not like 'Long%'

--Uitlizando cast para fazer um texto mais legivel
select distinct 
p.name,
cast(p.Name as char(10)) as nometratato,
    s.unitprice
from Sales.SalesOrderDetail as s
join Production.Product as p 
on s.ProductID = p.ProductID
where p.Name like 'Long-Sleeve Logo Jersey, M'


---Usanco cast com a cláusula like
select p.FirstName,
       p.LastName,
       A.SalesYTD,
       A.BusinessEntityID,
       CASt(cast(A.SalesYTD as int )as char(10)) cast1,
       cast(A.SalesYTD as char(40)) as cast2
from Person.Person as P
join Sales.SalesPerson as A 
 on p.BusinessEntityID = A.BusinessEntityID
where cast(CAST(A.SalesYTD as int ) as char(30)) like '2%'

--Try cast (Se estiver correto ele vai retornar no else)
select 
    case when TRY_CAST('teste' as float ) IS null
    then'Cast falhou'
    else 'cast ok'
end as result 

select 
    case when Try_cast(52 as float) is null
    then 'Falhado'
    else 'Cast sucesso'
end as result 


--Try cast (DATA INSERIDA INCORRETA)
set dateformat dmy
select TRY_CAST('12/31/2010' as datetime) as result
go

--Try cast (DATA INSERIDA CORRETA)
set dateformat dmy 
select TRY_CAST('01/12/2010' as datetime) as result
go

--Simulando erro
select try_cast('12/31/2010' as  datetime)
select cast('12/31/2010' as  datetime)

--EXEMPLOS PARSE E CULTURE 
--PARSE Retorna o resultado de uma expressão em, convertida no tipo de dado solicitado no SQL server
--string value deve ser uma representação válida do tipo de dados solicitado, ou parse gera um erro

--data type 
--valor literal que representa o tipo de dados solicitado para o resultado 
--culture 
--cadeia de caracteres opcional que identifica a cultura na qual string_value e formatado

select parse('Monday, 13 December 2010' as datetime using 'en-US') as result --(<-- pode ver pelo idioma configurado)

select parse('Segunda-Feira, 13 Dezembro 2010' as datetime using 'pt-Br') as result --(<-- pode ver pelo idioma configurado)

select PARSE('R$345,98' as money using 'Pt-Br') as salariado

select parse('$350' as money using 'en-Us') as result

set language 'English'
select PARSE('12/10/2010' as datetime ) as result

set language 'Português'
select PARSE('12/10/2010' as datetime ) as result

--Simulando erro 
set language 'Português'
select parse('12/30/2022' as datetime ) as result -- <-- Pode verificar que a data está em tipo en-US


--Try convert é qual  igual o Try cast (sendo pelo fato que tem que apontar o tipo de dado)

select 
case when TRY_CONVERT(float,65) is null
    then 'Erro'
    else 'Sucess'
end as result 

set dateformat dmy 
select TRY_CONVERT(datetime, '12/30/2012') as result --Nulo siginifica error
go

select Try_parse('$350' as money using 'en-Us') as result
