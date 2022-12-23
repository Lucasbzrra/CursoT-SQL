--Funçoes DATA E HORA


select SYSDATETIME() exSYSDATETIME
select SYSDATETIMEOFFSET() exSYSDATETIMEOFFSET
select SYSUTCDATETIME() exSYSUTCDATETIME
select CURRENT_TIMESTAMP exCURRENT_TIMESTAMP
select GETDATE() exGETDATE
select GETUTCDATE() exGETUTCDATE

--
select getdate() data_hora,
       DATENAME(day, GETDATE()) dia_mes,
       datename(month, getdate()) Mes_ano,
       datename(year,getdate()) Ano_N
---
select DATEPART(day,GETDATE()) Dia_p,
       DATEPART(month,GETDATE())mes_p,
       DATEPART(year,GETDATE())AnoP
----
select day(GETDATE())Dia,
        month(GETDATE())Mes,
        YEAR(GETDATE())An
----

select DATETIMEFROMPARTS(2017,11,30,3,45,59,1) hora

use crm

select nascimento,
        MONTH(nascimento) as mes,
        year(nascimento) as ano,
        day(nascimento) as mes from cliente


select month(a.nascimento) mes,
        year(a.nascimento) ano,
        count(*) qtd 
        from cliente a 
group by month(a.nascimento), year(a.nascimento)
order by year(a.nascimento) asc, month(a.nascimento) asc 

--DATEDIFF RETORNA DIFERENÇAS ENTRE AS DATA 

select DATEDIFF(YEAR,'11-05-1979',GETDATE()) as teset
select DATEDIFF(MONTH,'11-05-1979',GETDATE()) as teset
select DATEDIFF(DAY,'11-05-1979',GETDATE()) as teset


select nascimento, DATEDIFF(year,nascimento,GETDATE()) from cliente


--DATEADD ACIONAR UM VALOR ESPECIFICADO A MAIS
select GETDATE() agora,
        dateadd(year,10,GETDATE()),
        dateadd(day,10,GETDATE()),
        dateadd(MONTH,10,GETDATE())


select convert(varchar(5),GETDATE(),103)
select convert(varchar(5),GETDATE(),108)
select convert(varchar(5),GETDATE(),1)

--Puxando o mês de um forma mais simplificado
select CONVERT(varchar(10),GETDATE(),103),
        SUBSTRING(CONVERT(varchar(10),GETDATE(),103),4,2)

--Extensão 
select cast(day(GETDATE()) as varchar(2))+' De '+
        DATENAME(MM,GETDATE()) as [Dias e mes]


--Padrão da tabela 
use crm 
select a.nascimento,
       CONVERT(varchar(10), a.nascimento,120) padrao120,
       CONVERT(varchar(10), a.nascimento,103) padrao103,
       CONVERT(varchar(20), a.nascimento,100) padrao100,
       CONVERT(varchar(11), a.nascimento,100) padrao100,
       CONVERT(varchar(8), a.nascimento,100) padrao100
       from cliente a 