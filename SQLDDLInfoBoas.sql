use crm
go
--Criar tabelas extamentes iguias 
select * into copia from profissao

--Deleta a tabela com mais velocidade 
TRUNCATE TABLE copia

--Fazendo um bk em tabela temporaria que foi excluida (#BK_)
select * into #BK_copia from profissao

SELECT * from #BK_copia

--Contando linhas em tabelas temporarias (UMA TABELA TEMPORARIA SÒ EXISTI ATE O TEMPO DE CONEXÂO)
SELECT count(*) as contandolinhas 
from #BK_copia

TRUNCATE TABLE profissao

--Populando a tabela com dados da tabela temporaria, só funiona quando todos os dados são extamentes iguais.
insert into profissao
SELECT * from #BK_copia