
--funções de classificação
--as funções de classificaçao retornam um valor de classificaçao
--para cada linha em uma partiçao. dependendo da função usada,
--algumas linha podem receber o mesmo valor que outras.
--as funcoes de classificaçao são não determinadas 

use curso 
select rank() over (order by estado asc) as rank_uf,
      estado
from uf 


select rank() over (order by estado asc) as rank_uf,
        regiao,
        estado
from regiao


--Dsitribui as linhas de uma partiçao ordenada em um numero de grupos espeficado
-- os grupos são numerados, iniciando em um. para cada linha
--ntile retorna o número fo grupo qual linha pertence

select ntile(3) over (order by estado asc) as rank_uf,
        regiao,
        estado
from regiao


-- DENSE RANK
--Retorna a classificação de linhas dentro da partição de um conjunto de resultados, sem qualquer 
--lacuna na classficação. A classificação de uma linha é um mais o número de classificações distintas que vêm antes
--linha questão.

select DENSE_RANK() over (ORDER by regiao) as deniserank,
regiao,
estado 
from regiao