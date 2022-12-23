-- union não pode fazer com colunas com tipo de dado diferente 
select 1,1
UNION
select 'a',2

select 1,1
UNION
select 1,2

select 1,1
UNION 
select 1,1

select 1,1
UNION all
select 1,1

--Outras formas
use AdventureWorks2017
go

select city 
from Person.Address
where AddressID <15000

union  

select city 
from Person.Address
where AddressID >=15000

--UTILIZANDO O UNION ALL


select city 
from Person.Address
where AddressID <15000

union ALL  

select city 
from Person.Address
where AddressID >=15000



use crm
go

SELECT cidade,
        codigo_pais
        from cliente
        where codigo_pais = 'US'

UNION

SELECT cidade,
        codigo_pais
        from cliente
        where codigo_pais = 'BR'


--UTILIZANDO O UNION ALL

SELECT cidade,
        codigo_pais
        from cliente
        where codigo_pais = 'US'

UNION all

SELECT cidade,
        codigo_pais
        from cliente
        where codigo_pais = 'BR'
--UTILIZANDO ESTRUTURAS SUBQUERYS-- Forma não recomendavel de utilizar 

use crm

select  a.id_cliente,
        a.primeiro_nome,
        a.ultimo_nome,
        a.sexo
        from cliente  a 
        where a.id_cliente in (select b.id_cliente from carro_cliente b where b.ano ='1999')

select  a.id_cliente,
        a.primeiro_nome,
        a.ultimo_nome,
        a.sexo
        from cliente  a 
        where a.id_cliente in (select b.id_cliente from carro_cliente b where b.ano ='1999'
        and b.id_cliente in (select c.id_carro   from carro_montadora c where c.id_montadora =2))


--exemplo subquery

select  a.id_cliente,
        a.primeiro_nome,
        a.sexo,
        a.ultimo_nome,
        (SELECT b.nome_carro
            from carro_montadora b
            inner join carro_cliente c 
            on b.id_carro = c.id_carro
            and a.id_cliente = c.id_cliente) as nome_carro
        from cliente a

--retorando pais com sbselect

select a.id_cliente,
       a.primeiro_nome,
       a.ultimo_nome,
       a.codigo_pais,
       (select b.nome_pais from pais b where a.codigo_pais = b.codigo_pais) as nome_pais
       from cliente a 

--retorando  o pais e o idioma com subselect 

select a.id_cliente,
       a.primeiro_nome,
       a.ultimo_nome,
       a.codigo_pais,
       (select b.nome_pais   from pais b where a.codigo_pais = b.codigo_pais) as nome_pais,
       (select top 1 b.idioma from idiomas b where a.id_cliente = b.id_cliente ) as idioma
        from cliente a


--subselect com funcoes agregadas pratica não recomendavel

select a.id_montadora, a.nome_carro,
(select avg(b.ano) from carro_cliente b where a.id_carro=b.id_carro) media_ano,
(select min(b.ano) from carro_cliente b where a.id_carro =b.id_carro ) mais_antigo,
(select MAX(b.ano) from carro_cliente b where a.id_carro = b.id_carro) mais_novo,
(select count(*) from carro_cliente b where a.id_carro = b.id_carro) qtd
from 
carro_montadora a

select a.id_montadora, a.nome_carro,
(select avg(b.ano) from carro_cliente b inner join carro_montadora on
a.id_carro=b.id_carro) media_ano
from 
carro_montadora a

------utilizando o update com subquery
alter TABLE carro_montadora add qtd int 

update carro_montadora set qtd =(select COUNT(*) as qtd from carro_cliente b
        inner join carro_montadora c on
        c.id_carro = b.id_carro
        and carro_montadora.id_carro=b.id_carro
        group by b.id_carro)


