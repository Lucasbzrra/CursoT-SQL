create DATABASE Treino 

use Treino

create table Cidade (
    ID_Cidade int,
    Nome_Cidade VARCHAR(60),
    UF VARCHAR(2)

    CONSTRAINT PK_ID_Cidade PRIMARY key (ID_Cidade)
)

create TABLE Cliente (
    Id_Cliente int,
    Nome_Cliente VARCHAR(60),
    Endereco VARCHAR(60),
    Numero VARCHAR(10),
    ID_Cidade int,
    Cep VARCHAR(9)

    CONSTRAINT PK_Id_Cliente PRIMARY key (Id_Cliente),
    CONSTRAINT FK_ID_Cidade FOREIGN key (ID_Cidade) REFERENCES Cidade(ID_Cidade)
)

CREATE TABLE VENDEDORES (
    ID_Vendedor int,
    Nome_vended VARCHAR(60),
    Salario DECIMAL(10,2)
    CONSTRAINT PK_ID_Vendedor PRIMARY key (ID_Vendedor)
)
create table Vendas(
    Num_Vend int,
    Data_Ven datetime,
    Status CHAR(1),
    Id_Cliente int ,
    ID_Vendedor int ,

    CONSTRAINT PK_Num_Vend PRIMARY key (Num_Vend),
    CONSTRAINT FK_Id_Cliente_Vendas FOREIGN key (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    CONSTRAINT FK_Id__Vendedor FOREIGN key (Id_Cliente) REFERENCES VENDEDORES(ID_Vendedor)

)

if OBJECT_id('Categoria','U')is NOT NULL
DROP TABLE Categoria
create TABLE Categoria(
    Id_Categoria int,
    Nome_categor VARCHAR(20),

    CONSTRAINT PK_Categoria PRIMARY key (Id_Categoria)
)

if OBJECT_id('Unidade','U')is NOT NULL
DROP TABLE Unidade
create TABLE Unidade(
    Id_Unicade int,
    Desc_Unidade VARCHAR(20),
    
    CONSTRAINT PK_Unidade PRIMARY key (Id_Unicade)
)


if object_id('Produtos','U') is not null 
drop table Produtos
create TABLE Produtos(
    ID_Prod int,
    Nome_Prod VARCHAR(50),
    Preco DECIMAL(10,2),
    Id_Unicade int,
    Id_Categoria int,
    CONSTRAINT PK_Produtos PRIMARY key (ID_Prod),
    CONSTRAINT FK_Id_Unicade_Produtos FOREIGN key (Id_Unicade) REFERENCES Unidade(Id_Unicade),
    CONSTRAINT FK_id_Id_Categoria_Produtos FOREIGN key (Id_Categoria) REFERENCES Categoria(Id_Categoria)
)

if OBJECT_ID('Venda_Itens','u') is not null 
drop TABLE Venda_Itens
create table Venda_Itens(
    Num_ve int,
    Num_se int,
    Qtd DECIMAL(10,2),
    Val_uni DECIMAL(10,2),
    Val_Tot DECIMAL(10,2),
    CONSTRAINT PK_Venda_Itens PRIMARY key (Num_ve)
)
---------------------------------------------------------------------------------------------------------------------------------------
--2

use master

RESTORE FILELISTONLY
            FROM DISK = 'C:/Program Files/Microsoft SQL Server/MSSQL15.MSSQLSERVER/MSSQL/Backup/TREINO.bak'
GO


RESTORE DATABASE Foi
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\TREINO.bak'
   WITH MOVE 'TREINO' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\TREINO.mdf',
        MOVE 'TREINO_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\TREINO_log.ldf'
GO


---------------------------------------------------------------------------------------------------------------------------------------
--3
use Foi

select cl.NOME_CLIENTE,cd.NOME_CIDADE,cd.UF from CIDADE cd 
inner join CLIENTE cl
on cd.ID_CIDADE = cl.ID_CIDADE;



---------------------------------------------------------------------------------------------------------------------------------------
--4
select pr.id_prod, du.desc_unidade ,pr.PRECO, ct.nome_categoria from PRODUTOS pr
inner join UNIDADE du 
on du.ID_UNIDADE=pr.ID_UNIDADE 
inner join CATEGORIA ct 
on ct.ID_CATEGORIA=pr.ID_CATEGORIA
where PRECO BETWEEN 10.00 and 1500
ORDER by PRECO;

---------------------------------------------------------------------------------------------------------------------------------------
--5
select ps.ID_PROD,ct.NOME_CATEGORIA, 
case  
when ps.PRECO < 500 then 'Preco abaixo de 500'
when ps.PRECO between 500 and 1000 then 'Preco entre 500 e 1000'
else  'preco a acima 1000' 
end  Preices
from PRODUTOS ps
inner join CATEGORIA ct 
on ps.ID_CATEGORIA =ct.ID_CATEGORIA;

---------------------------------------------------------------------------------------------------------------------------------------
--6
alter TABLE VENDEDORES ADD  faixa_salario CHAR(1)

---------------------------------------------------------------------------------------------------------------------------------------
--7
select * from VENDEDORES

update VENDEDORES set faixa_salario = case 
                                      when SALARIO<1000 then 'c'
                                      when SALARIO between 1000 and 2000 then 'b'
                                      else 'a'
                                      end ;

---------------------------------------------------------------------------------------------------------------------------------------
--8
select NOME_VENDEDOR,SALARIO, SALARIO+SALARIO*0.12 as aumentos  from VENDEDORES
order by NOME_VENDEDOR asc;

---------------------------------------------------------------------------------------------------------------------------------------
--9
select NOME_VENDEDOR,SALARIO, (SALARIO+SALARIO*0.12) as aumentos, (SALARIO+SALARIO*0.12)*0.18 as reajuste from VENDEDORES


select NOME_VENDEDOR,SALARIO, (SALARIO+SALARIO*0.12) as aumentos,
case
when lower(faixa_salario) <>'c' then  (SALARIO+SALARIO*0.18) 
else (SALARIO+SALARIO*0.12) 
end
from VENDEDORES
order by NOME_VENDEDOR;


---------------------------------------------------------------------------------------------------------------------------------------
--10--

select top(1)NOME_VENDEDOR from VENDEDORES
order by SALARIO asc ;

---------------------------------------------------------------------------------------------------------------------------------------
--11
select COUNT(nome_vendedor) from VENDEDORES
where SALARIO>2000;
---------------------------------------------------------------------------------------------------------------------------------------
--12
alter table vendas add valor_total DECIMAL(10,2);

---------------------------------------------------------------------------------------------------------------------------------------
--13
update VENDAS set valor_total=(select sum(VAL_TOTAL) from VENDA_ITENS a 
where vendas.NUM_VENDA=a.NUM_VENDA);

---------------------------------------------------------------------------------------------------------------------------------------
--14

select a.NUM_VENDA,a.valor_total,sum(b.val_total) total_itens  from VENDAS a 
join VENDA_ITENS b 
on a.NUM_VENDA =b.NUM_VENDA
GROUP by a.NUM_VENDA, a.valor_total having a.valor_total<>SUM(b.VAL_TOTAL);

---------------------------------------------------------------------------------------------------------------------------------------
--15

select vi.NUM_VENDA, count(vi.NUM_SEQ),sum(QTDE) ,avg(VAL_UNIT) from Venda_Itens vi
join VENDAS vd 
on vd.NUM_VENDA=VI.NUM_VENDA
where year(DATA_VENDA)=2018 and month(DATA_VENDA)=07
GROUP by vi.NUM_VENDA,vd.valor_total;

---------------------------------------------------------------------------------------------------------------------------------------
16-
select count(NUM_VENDA),
       avg(valor_total) media tck,
       min(valor_total) tck min, 
       max(valor_total) tck max  
from VENDAS
where year(DATA_VENDA)=2017 and MONTH(DATA_VENDA)=07;


---------------------------------------------------------------------------------------------------------------------------------------
17-
select * from VENDAS
update  vendas set status ='C' where num_venda in (15,
                                               34,
                                               80,
                                               104,
                                               130,
                                               159,
                                               180,
                                               240,
                                               350,
                                               420,
                                               422,
                                               450,
                                               480,
                                               510,
                                               530,
                                               560,
                                               600,
                                               640,
                                               670,
                                               714)

---------------------------------------------------------------------------------------------------------------------------------------
--18-
select * from CLIENTE
select * from VENDAS



select vd.ID_Cliente, cl.Nome_Cliente,
case 
when count(vd.ID_CLIENTE)>=70  then count(vd.NUM_VENDA)
end 
from VENDAS vd
inner join CLIENTE cl 
on cl.ID_CLIENTE =vd.ID_CLIENTE
where [STATUS] = 'N'
GROUP by vd.ID_CLIENTE,cl.Nome_Cliente;


select vd.ID_Cliente, cl.Nome_Cliente,count(vd.NUM_VENDA) from VENDAS vd
inner join CLIENTE cl 
on cl.ID_CLIENTE=vd.ID_CLIENTE
where vd.[STATUS] ='N'
GROUP by NOME_CLIENTE,vd.ID_CLIENTE
having count(vd.NUM_VENDA)>=70;

---------------------------------------------------------------------------------------------------------------------------------------

--19---

-- incorreta
select vi.NUM_VENDA, sum(QTDE) from VENDA_ITENS vi 
inner join VENDAS pr 
on vi.NUM_VENDA = pr.NUM_VENDA
where [STATUS] =N'N'
GROUP by vi.ID_PROD,sum(QTDE)
having sum(QTDE)>100;

---Correta
with T as 
(select a.num_venda, SUM(b.QTDE) as qtd
from vendas a 
inner join VENDA_ITENS b 
on a.NUM_VENDA=b.NUM_VENDA
where a.[STATUS]='N'
group by a.NUM_VENDA having SUM(b.QTDE)>100
)

select  A.NUM_VENDA, b.ID_PROD,c.NOME_PRODUTO,b.QTDE
from T A
inner join VENDA_ITENS B 
on A.NUM_VENDA = B.NUM_VENDA
inner join PRODUTOS C 
on b.ID_PROD = c.ID_PROD


---------------------------------------------------------------------------------------------------------------------------------------
--20--

select  isnull(cr.NOME_CATEGORIA,'Total'), SUM(VAL_TOTAL) as total from PRODUTOS pr 
inner join VENDA_ITENS vi 
on pr.ID_PROD=vi.ID_PROD
inner join VENDAS vs 
on vs.NUM_VENDA=vi.NUM_VENDA
inner join CATEGORIA cr 
on cr.ID_CATEGORIA=pr.ID_CATEGORIA
where year(DATA_VENDA)=2017
GROUP by  rollup(cr.NOME_CATEGORIA);




---------------------------------------------------------------------------------------------------------------------------------------
--21
---------------------------------------------------------------------------------------------------------------------------------------
select  
ISNULL(substring(CONVERT(VARCHAR(10),vs.DATA_VENDA,103 ),4,10),'total geral') mes,
isnull(cr.NOME_CATEGORIA,'Total'), SUM(VAL_TOTAL) as total from PRODUTOS pr 
inner join VENDA_ITENS vi 
on pr.ID_PROD=vi.ID_PROD
inner join VENDAS vs 
on vs.NUM_VENDA=vi.NUM_VENDA
inner join CATEGORIA cr 
on cr.ID_CATEGORIA=pr.ID_CATEGORIA
where year(DATA_VENDA)=2017
GROUP by  rollup(cr.NOME_CATEGORIA,(substring(CONVERT(VARCHAR(10),vs.DATA_VENDA,103 ),4,10),cr.NOME_CATEGORIA))


---------------------------------------------------------------------------------------------------------------------------------------
--22
---------------------------------------------------------------------------------------------------------------------------------------
select v.NOME_VENDEDOR,va.ID_VENDEDOR, sum(va.valor_total),month(DATA_VENDA)
from VENDEDORES v
INNER join VENDAS va 
on va.ID_VENDEDOR=v.ID_VENDEDOR
where YEAR(DATA_VENDA)=2017
and va.[STATUS] =N'N'
GROUP by va.ID_VENDEDOR,v.NOME_VENDEDOR,month(DATA_VENDA)


select  
ISNULL(substring(CONVERT(VARCHAR(10),VENDAS.DATA_VENDA,103 ),4,10),'total geral') mes,
isnull(vs.NOME_VENDEDOR,'Total') as vendedor,
SUM(valor_total) val_total
from VENDAS  
inner join VENDEDORES vs 
on VENDAS.ID_VENDEDOR=vs.ID_VENDEDOR
where year(DATA_VENDA)=2017
GROUP by rollup(SUBSTRING(convert(varchar(10), VENDAS.DATA_VENDA,103),4,10),vs.NOME_VENDEDOR)

---------------------------------------------------------------------------------------------------------------------------------------
--23
---------------------------------------------------------------------------------------------------------------------------------------

select top(10) with ties  pr.ID_PROD,pr.NOME_PRODUTO, ct.NOME_CATEGORIA, sum(VAL_TOTAL) as   total from CATEGORIA ct 
inner join PRODUTOS pr 
on pr.ID_CATEGORIA=ct.ID_CATEGORIA
inner join VENDA_ITENS vs 
on vs.ID_PROD=pr.ID_PROD 
GROUP by pr.ID_PROD ,pr.NOME_PRODUTO,ct.NOME_CATEGORIA
ORDER by sum(VAL_TOTAL) desc

---------------------------------------------------------------------------------------------------------------------------------------
--24
---------------------------------------------------------------------------------------------------------------------------------------
declare @valor DECIMAL(10,2);
select  @valor =  sum(VAL_TOTAL) from VENDA_ITENS

select   pr.ID_PROD,pr.NOME_PRODUTO, ct.NOME_CATEGORIA, sum(VAL_TOTAL) as   total, 100/@valor*sum(VAL_TOTAL) as percert
from CATEGORIA ct 
inner join PRODUTOS pr 
on pr.ID_CATEGORIA=ct.ID_CATEGORIA
inner join VENDA_ITENS vs 
on vs.ID_PROD=pr.ID_PROD 
GROUP by pr.ID_PROD ,pr.NOME_PRODUTO,ct.NOME_CATEGORIA
ORDER by sum(VAL_TOTAL) desc

---------------------------------------------------------------------------------------------------------------------------------------
--25
---------------------------------------------------------------------------------------------------------------------------------------



select MONTH(A.DATA_VENDA) as mes,
        b.ID_PROD,
        SUM(B.VAL_TOTAL) as valor 
        into #Etapa1
from VENDAS A 
inner join VENDA_ITENS B 
on A.NUM_VENDA=B.NUM_VENDA
GROUP by MONTH(A.DATA_VENDA),B.ID_PROD
order by MONTH(A.DATA_VENDA) asc, 3 desc



SELECT ROW_NUMBER() OVER (PARTITION BY MES ORDER BY MES ASC,VALOR DESC) POSICAO,
       MES,
	   ID_PROD,
	   VALOR
  INTO #ETAPA2
FROM #Etapa1


SELECT A.POSICAO,A.MES,B.NOME_PRODUTO,A.VALOR
FROM #ETAPA2 A
INNER JOIN PRODUTOS  B
ON A.ID_PROD=B.ID_PROD
WHERE A.POSICAO=1
ORDER BY A.MES



---------------------------------------------------------------------------------------------------------------------------------------
--26
---------------------------------------------------------------------------------------------------------------------------------------
select A.ID_CLIENTE,A.NOME_CLIENTE,CAST(B.DATA_VENDA as date ) as Dt_ult_Com, b.NUM_VENDA
from (select id_cliente, max(data_venda) as data_venda from VENDAS where [STATUS] ='N' GROUP by ID_CLIENTE ) as X 
INNER join CLIENTE A 
on A.ID_CLIENTE=X.ID_CLIENTE
inner join VENDAS B 
on A.ID_CLIENTE=B.ID_CLIENTE
And A.ID_CLIENTE=X.ID_CLIENTE
And B.DATA_VENDA=X.data_venda


---------------------------------------------------------------------------------------------------------------------------------------
--27
---------------------------------------------------------------------------------------------------------------------------------------


select A.ID_PROD,A.NOME_PRODUTO,T1.data_venda as data_venda
from PRODUTOS A 
inner join (select C.ID_Prod, max(B.DATA_VENDA) as data_venda
from VENDAS B 
inner join VENDA_ITENS C 
on B.NUM_VENDA=C.NUM_VENDA
GROUP by C.ID_PROD) T1
on A.ID_PROD=T1.ID_PROD

---------------------------------------------------------------------------------------------------------------------------------------