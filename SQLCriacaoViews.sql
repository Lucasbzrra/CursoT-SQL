use AdventureWorks2017


--Criação de VIEWs 
--reuso: views são objetos de caráter permanente 
--segurança as views permitem que ocultemos determinadas colunas e tabela
---as views permite um criação de código mais limpo
create VIEW Vw_Data_Contratacao 
as 
select  p.FirstName,
        p.LastName,
        e.BusinessEntityID,
        e.HireDate 
        from HumanResources.Employee e 
        join Person.Person as p
        on e.BusinessEntityID =p.BusinessEntityID

--Executa a view
select * from Vw_Data_Contratacao
--Outra forma 
select * from Vw_Data_Contratacao
where YEAR(HireDate)='2009'



--Criando view utilizando o UNION ALL
use curso 
create table Fornecedores1(
    id_for int PRIMARY key check (id_for BETWEEN 1 and 20),
    forne VARCHAR(20)
)

create table Fornecedores2(
    id_for int PRIMARY key check (id_for BETWEEN 20 and 40),
    forne VARCHAR(20)
)

insert into Fornecedores1 values (1,'Ordebrexe')
insert into Fornecedores1 values (2,'Vale')
insert into Fornecedores2 values (10,'Sinsecruty')
insert into Fornecedores2 values (12,'OliverGardon')

create view Vw_TabelasSeparas as 
SELECT id_for,forne from Fornecedores1 
UNION all 
SELECT id_for,forne from Fornecedores1 

select * from Vw_TabelasSeparas