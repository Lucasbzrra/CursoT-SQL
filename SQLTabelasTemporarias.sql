--Temp table 
--Tabelas témporarias são criadas no database TempDb e podem ser classificadas como locais e globais 
---Tabela local usa-se # 
--Tabela Global usa-se ##
--Tabela temporária (local ou global ) só existe equanto a conexão responsável pela sua criação estiver ativa.
use curso 

--Criando tabela temporária

create TABLE #minhatemporari(
    campo VARCHAR(20) not null,
    campo2 money not null 
)

---inserindo registros na table temporaria

insert into #minhatemporari VALUES('real',1000),
                                 ('dolar',3000)

select * from #minhatemporari

--criando um tabela temporaria através de um select 

select * into #minhatemporaria2 from #minhatemporari

select * from #minhatemporaria2

----
update #minhatemporaria2 set campo='Euro'
where campo='real'

select * from #minhatemporaria2


delete from  #minhatemporaria2
drop table #minhatemporaria2
----------


--Criando uma temmporaria com select e inserindo registros de tabela permanente
select nome_mun into #cidadeTempo from senso

select * from #cidadeTempo

