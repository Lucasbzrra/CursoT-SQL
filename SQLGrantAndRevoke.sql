-- --Criando um usuário de login 
-- exec master .dbo.sp_Addlogin 'UsrTeste','SenhaTeste';

-- --adcionar o usuario ao banco de dado (curso)
-- exec sp_grantdbaccess 'UsrTeste'

--Conceder acesso ao tipos comando que o mesmo poderá executar
-- grant UPDATE on regiao to UsrTeste;
-- grant delete on regiao to UsrTeste;
-- grant select on regiao to UsrTeste;
-- grant INSERT on regiao to UsrTeste;

--CONCEDER ACESSO A TABELA SOMENTE PARA TABELAS ESPECIFICADAS
--grant select  on pedido_detalhe to UsrTeste 


---CONCEDER ACESSO UMA PROCEDURE 
-- CREATE PROCEDURE AcessoTest 
-- AS
-- SELECT * from regiao

-- EXEC AcessoTest

-- grant execute on AcessoTest to UsrTeste;

--verificar o usuário logado

-- SELECT CURRENT_USER

--Alterar o usuário logado

-- SETUSER 'UsrTeste'
-- SELECT CURRENT_USER

--Revogaçao de Acessos


-- revoke UPDATE on regiao to UsrTeste;
-- revoke delete on regiao to UsrTeste;
-- revoke select on regiao to UsrTeste;
-- revoke INSERT on regiao to UsrTeste;

-- revoke execute on AcessoTest to UsrTeste;

--Para Acessar com usuário adm
-- SETUSER

--DENY (Ele nega autorizacao de acesso é não revoga acessos)

-- deny UPDATE on regiao to UsrTeste;

-- deny  select (val_unit) on pedido_detalhe to UsrTeste

-- deny  update (val_unit) on pedido_detalhe to UsrTest