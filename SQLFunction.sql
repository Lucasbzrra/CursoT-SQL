--Funçoes Escalares --Aquela função que retornar um valor exemplo seria a SUM
use curso

--Sempre que for criar um função escalaras tem colocar a estrutura returns (tipo de dados)
create function Fn_TrimRtrim(@str as varchar(100))
returns varchar(100)
    begin 
        return (Ltrim(rtrim(@str)))
    end 


--Invocando a funcao
select 'Teset     '+'1'
UNION 
select '.'+dbo.Fn_TrimRtrim('   Teset     ')+'1'


---Outra funcao
alter  function Fn_Soma( @num1 int, @num2 int )
returns decimal(10,6)
    begin 
        declare @result decimal(10,6)
        set @result =@num1/@num2
        return @result
    end


select dbo.Fn_Soma(500,7)

--Outra forma 
create table Saldos(
    NumConta varchar(10) not null,
    SaldoInicial decimal (10,2),
    SaldoFinal decimal(10,2)
    CONSTRAINT pkNumConta PRIMARY key(NumConta) 
)
insert into Saldos values('123-9',1000,1000),
                         ('124-7',1000,500),
                        ('125-6',500,1000)

-----
create function Fn_Saldo(@num decimal, @num2 decimal)
returns decimal 
    begin 
        declare @result decimal 
        select @result=@num-@num2
        return @result
    end 
select * from Saldos
select NumConta,SaldoInicial,SaldoFinal, dbo.Fn_Saldo(SaldoInicial,SaldoFinal) as credito from Saldos

-----
create function Saldo(@conta varchar(10))
returns decimal 
as
begin 
    declare @saldo decimal;
    select @saldo = SaldoInicial-SaldoFinal
        from Saldos
        where NumConta=@conta;
    if (@saldo is null )
    set @saldo = 0
    return @saldo 
end 

select NumConta,
        SaldoInicial,
        SaldoFinal,
        dbo.Saldo(NumConta) as saldo 
        from Saldos
----------------
--FUNCTION  TABELA
----------------
create or alter function dbo.func_dias(@dia int, @dti datetime, @dtf datetime)
returns @tbl table (seq int, dt datetime)
as 
begin 
    declare @cont int=1;
    while @dti <=@dtf 
        begin 
            INSERT into @tbl (seq,dt) values (@cont, @dti)
            set @dti = DATEADD(day, @dia,@dti)
            set @cont=@cont+1
        end 
        return 
end 

select * from dbo.func_dias(1,GETDATE(),GETDATE()+10)

--Outro EXEMPLO
use curso 

create or alter FUNCTION FnCidade(@uf varchar(20))
returns table 
as 
return (select a.nome_mun,a.populacao from senso a
where a.uf=@uf )


select * from dbo.FnCidade('Tocantins')

-------
select * from senso 
select * from regiao
-------
--Outro exemplo
-------
create or alter FUNCTION Testetabela(@regiao varchar(20))
returns table 
as 
return(
    select s.cod_uf,r.estado,r.regiao, SUM(s.populacao) as total from senso s 
    inner join regiao r 
    on r.cod_uf=s.cod_uf
    where r.regiao=@regiao
    group by s.cod_uf,r.estado,r.regiao
)

select * from dbo.Testetabela('Sudeste')
------------------------------
use crm 
select * from profissao

create or alter function TestandoTudo(@profissa varchar(30))
returns table 
as
return(select id_profissao,nome_profissao from profissao
    where nome_profissao =@profissa
)

select * from dbo.TestandoTudo('Senior Developer')