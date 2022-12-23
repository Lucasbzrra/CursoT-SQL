

--função de agregaçao
use curso
select top 5 * from senso
SELECT top 5 * from uf 
select top 5 * from regiao

---avg retornar a media de valores 
SELECT avg(populacao) from senso

--media do estado avg
select uf,avg(populacao) as qtd from senso
GROUP by uf 
order by 2  desc -- o "2" significa segundo campo ou poderia usar um alis qtd e indicar qtd

--avg por regiao
select b.regiao,avg(a.populacao) 
from   senso a 
inner join regiao b 
on b.cod_uf = a.cod_uf
GROUP by b.regiao
order by 2  desc

--minino por regiao
select min(populacao) from senso

--minino por estado
select uf,MIN(populacao)
from senso
GROUP by uf 
order by 2

--minino por regiao
select regiao, min(a.populacao) from senso a
inner join regiao b 
on b.cod_uf =a.cod_uf
GROUP by regiao
ORDER by 2 desc 

-- maximo por regiao
select max(populacao) from senso 

-- maximo por estado
select uf, MAX(populacao) from senso
GROUP by uf 
order by 2

-- maximo por regiao
select regiao, max(a.populacao) from senso a 
inner join regiao b 
on b.cod_uf =a.cod_uf
group by regiao
order by 2 desc 

--soma 
select sum(populacao) from senso

--soma por estado

select UF, SUM(populacao) from senso a 
GROUP by UF 
ORDER by 2  desc 

--soma por regiao 
select b.regiao, SUM(a.populacao) from senso a 
inner join regiao b 
on b.cod_uf = a.cod_uf
group by regiao
order by 2 desc 

-- count retonrar o numero de intens no group

select COUNT(*) from senso

-- count retonrar o numero de intens no group sem repetidos
select COUNT(distinct uf ) from senso 

--count por estado
select uf, COUNT(*) qtd from senso 
GROUP by uf 
order by qtd desc 

--count por regiao

select R.regiao, COUNT(*) from senso  a 
inner join regiao R 
on R.cod_uf = a.cod_uf
GROUP by regiao
order by 2 desc 

--bonus

select B.regiao,
       avg(populacao) mediapop,
       min(populacao) mininapop,
       max(populacao) maximopop,
       sum(populacao) totalpopo,
       count(*) qtdcidade
       from senso a 
inner join regiao B 
on B.cod_uf = a.cod_uf
group by B.regiao
ORDER by 2 asc  


--stedv retorna o desvio padrao estatitisco todos os valores da expressao especificada

select STDEV(populacao) from senso

---grouping indica se uma expressao de coluna espesificada em uma lista 
--group by e agregacao ou nao. grouping retornar 1 para agregada ou 0 para mão agregadada

select uf, sum(populacao) as pop,
GROUPING(uf) as grupo 
from senso 
group by uf WITH rollup--OLHE NA ULTIMA LINHA



--projetando crescimento

select a.nome_mun,
       a.populacao,
       (a.populacao * 1.05) as projecao
from senso a 


select a.uf,
       sum(a.populacao),
       sum(a.populacao)*1.05 as projecao
from senso a 
GROUP by uf 



--é uma funçao que calcula o nivel de agrupamento.
--GROUPING_ID pode ser usada apneas na lista select <select >
-- na cláusula having ou order by, quando group by for especificada 

select b.regiao, a.uf, SUM(a.populacao) populacao,
GROUPING_ID(b.regiao,a.uf) as grupo --(OLHE NA NO DADOS 1 SÂO A SOMAS DE CADA REGIAO) 
from senso a 
inner join regiao b 
on b.cod_uf = a.cod_uf
GROUP by  rollup (b.regiao,a.uf)


--VAR retornar a variancia estatistica de todos os valores da expressão espeficidada 
select var(populacao) from senso

select uf,var(populacao) from senso 
group by uf 

--VARP retornar a variancia estatistica para o preenchimento
--de todos os valores da expressao especificada
select varp(populacao) from senso 


select uf, varp(populacao) from senso
group by uf  

select uf,var(populacao) var,varp(populacao) varp from senso
group by uf 

--exemplo de grouping 
use crm

select codigo_pais,
       COUNT(*) 'wtd',
       GROUPING(codigo_pais) as 'grouping'
from cliente
group by codigo_pais with rollup

--outros exemplos

select a.nome_montadora,
       count(*) 'qtd',
       GROUPING(a.nome_montadora) as 'grouping'
from montadora a
inner join carro_montadora b 
on b.id_montadora=a.id_montadora
GROUP by a.nome_montadora with ROLLUP



select a.nome_montadora,
       b.nome_carro,
       count(*) as 'qtd',
       GROUPING(a.nome_montadora) as 'grouping'
from montadora a 
inner join carro_montadora b 
on b.id_montadora=a.id_montadora
where a.nome_montadora in ('Toyota','volksvagewm')
GROUP by a.nome_montadora,b.nome_carro with ROLLUP


--Trazendo o nome da cidade com maior populacao em cada estado
use curso;

select a.* from 
(select cod_uf, max(populacao) as populacao from senso group by cod_uf) b 
 join senso a 
on a.cod_uf = b.cod_uf
and a.populacao = b.populacao 
order by a.populacao desc  

--Trazendo o nome da cidade com maior populacao em cada estado outra forma 

select a.cod_uf, a.nome_mun, a.populacao
from senso a
group by a.cod_uf, a.nome_mun, a.populacao
having populacao=(select max(populacao) from senso where cod_uf=a.cod_uf)
order by a.populacao desc 
