
--Executando TCL mais utilizados em procedures 

-- CREATE TABLE Cadastro (
--     Nome varchar(100),
--     Cpf CHAR(3)
-- )
-- insert into Cadastro values ('jason Todd',001),
--                             ('Wilson',002),
--                             ('Luquet',003)

-- begin TRANSACTION

-- drop TABLE Cadastro

-- ROLLBACK TRANSACTION

-- SELECT * from Cadastro

-------------------


--Executando TCL mais utilizados em procedures 
-- CREATE TABLE Cadastro (
--     Nome varchar(100),
--     Cpf CHAR(3)
-- )

-- --Incia as transações de salvar (begin trasaction)
-- begin TRANSACTION


-- insert into Cadastro values ('jason Todd',001)
-- --Cria um checkpoint de salve, estilo jogo (save transaction).
-- save TRANSACTION a1

-- insert into Cadastro values  ('Wilson',002)
-- --Cria um checkpoint de salve, estilo jogo (save transaction).
-- save TRANSACTION a2

-- insert into Cadastro values   ('Luquet',003)
-- --Cria um checkpoint de salve, estilo jogo (save transaction).
-- save TRANSACTION a3


-- drop TABLE Cadastro

-- --ROLLBACK utilizado para restaurar do ponto de deseja, dependendo não precisar espesificar no (a1,a2,a3)
-- ROLLBACK TRANSACTION a2

-- --Efetiva as trasacoes da tabela (salva fixamente de vez)
-- commit TRANSACTION

-- SELECT * from Cadastro