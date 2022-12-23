--Procedures (Procedimentos armazenados)
--Um procedimento armazenado é um tipo especial de script escrito em Transact-SQL, 
--usando a linguagem SQL e extensões SQL.
--Os procedimentos são salvos em servidor de banco de dados para aperfeiçoar o desempenho
--e consistência das tarefas repetitivas.
--Procidmentos armazendados podem ser usados para as seguintes tarefas:
--Controlar autorização de acesso.
--Criar um caminho de auditoria de atividades em tabelas de banco de dados.
--Separar instuções de definição e de manipulação de dados relativas a um banco de dados
--Das aplicações que o acessam

--Estrutura

--create or alter procedure [nome] (com parâmetros)
--as
--begin 
--[expressão ]
-- end 

--Exemplo 1
Create or alter PROCEDURE Texts (@1000 varchar( 100) )
as 
begin 
select 'Texzty'+@1000
end 

exec Texts'Lucas'

---Outras Formas
create or alter procedure ProMsgboaVnda
as 
begin 
print 'Seja bem vindo'+' '+SYSTEM_USER
if DATEPART(HOUR,GETDATE())>=6 and datepart(HOUR,GETDATE())<=12
print 'bom dia'
else if datepart(hour,GETDATE())>12 and DATEPART(HOUR,GETDATE())<18
PRINT'boa tarde'
else 
PRINT 'Bonas Noite'
end

exec ProMsgboaVnda


-------------
create or alter PROCEDURE CalculoImc(@peso decimal(10,2), @altura DECIMAL(10,2) )
as 
begin 
DECLARE @result DECIMAL(10,2)=@peso/@altura*@altura
if @result<17
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'muito abaixo'
    end
else if @result>=17 and @result<=18.49
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'abaixo'
    end
else if @result>=18.5 and @result<=24.99
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'normal'
    end
else if @result>=25.0 and @result<=29.99
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'Acima do peso'
    end
else if @result>=30 and @result<=34.99
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'Obsedidade I'
    end
else if @result>=35 and @result<=39.99
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'Obsedidade II'
    end
else if @result>=40
    begin 
        select 'Seu peso está'+cast(@result as varchar) +'Obsedidade III'
    end
END

EXEC CalculoImc 75,1.74


--------------
create or alter PROCEDURE Calculdadora (@operador char(1),@num1 int,@num2 int )
as
begin 
DECLARE @result int 
    if upper(@operador)='A'
        begin 
            set @result=@num1+@num2
            select @result
        end
    else if upper(@operador)='M'
        begin 
            set @result=@num1*@num2
            select @result
        end
    else if upper(@operador)='S'
        begin 
            set @result=@num1-@num2
            select @result
        end
    else 
        begin 
            set @result=@num1/@num2
            select @result
        end
END

EXEC Calculdadora 'A',2,2
EXEC Calculdadora 'M',2,2
EXEC Calculdadora 'S',2,2
EXEC Calculdadora 'te',2,2

-----------------
--CRUD PROCEDURE
-----------------

-- use curso
-- GO
-- CREATE table Cad_Pessoa(
--     ID_Pessoa int not null PRIMARY key,
--     Nome VARCHAR(50),
--     Email VARCHAR(30),
--     Situacao CHAR(1),
--     CONSTRAINT CK_Situa CHECK(Situacao in ('B','A'))
-- )

-- create procedure SP_Crud (@V_Oper char(1),@v_IdPessoa integer,@v_Nome varchar(50),@v_Email varchar(30),@v_Situa char(1))
-- as 
-- begin 
-- DECLARE @V_Sid_Pessoa INTEGER,
--         @V_SNome VARCHAR(50),
--         @V_SEmail VARCHAR(30),
--         @v_SSitua CHAR(1)
-- begin TRANSACTION


-- if (@V_Oper='I')
-- begin 
--     if (@v_IdPessoa is null or @v_IdPessoa=''or @v_Nome is null or @v_Nome=''
--     or @v_Email is null or @v_Email='')
--     begin 
--         ROLLBACK
--         print 'Campos Imcompletos'
--         GOTO FIM_ERRO
--     end 
--     ELSE
--         INSERT into Cad_Pessoa(ID_Pessoa,Nome,Email,Situacao) values (@V_Sid_Pessoa,@V_SNome,@V_SEmail,'A')
--         GOTO FIM_CERTO
--     end 
-- end 


-- if (@V_Oper='A')
-- begin 
--     if(@v_IdPessoa is null or @v_IdPessoa '')
--         begin 
--             ROLLBACK
--             print 'Campos Imcompletos'
--             GOTO FIM_ERRO 
--     end 
-- else 
-- UPDATE Cad_Pessoa set Nome = ISNULL(@v_Nome,Nome),Email=ISNULL(@v_Email,Email),
-- Situacao=ISNULL(@v_Situa,Situacao)
-- WHERE ID_Pessoa=@v_IdPessoa
-- goto FIM_CERTO
-- END

-- if(@V_Oper='D') begin 
--  if (@v_IdPessoa is null or @v_IdPessoa='')
--     begin 
--     ROLLBACK
--     print 'Campos Imcompletos'
--     goto FIM_ERRO 
--     end 
--     else 
--         Delete from Cad_Pessoa where ID_Pessoa = @v_IdPessoa;
--         GOTO FIM_CERTO
--  end 

-- if (@V_Oper='S')
--     BEGIN
--     select @V_Sid_Pessoa=a.ID_Pessoa,@V_SNome=A.Nome,@V_SEmail=Email,@v_SSitua=Situacao
--     from Cad_Pessoa a 
--     where ID_Pessoa=@v_IdPessoa
--         PRINT CONCAT('ID:',@V_Sid_Pessoa);
--         PRINT 'Nome'+@V_SNome;
--         PRINT 'e-mail'+@V_SEmail;
--         PRINT 'Situacao'+@v_SSitua;
--         goto FIM_CERTO

--     END

--  FIM_CERTO:
--  COMMIT; 
--  PRINT 'DADOS SELECIONADOS,INSERIDOS OU ATUALIZADO COM SUCESSO'; 
--  GOTO FIM
 
--  FIM_ERRO:
--  PRINT 'ALGO DEU ERRADO!!!'; 

--  FIM:
--  PRINT 'FINALIZADO!!!'; 


-- --INSERT
--  EXECUTE   SP_CRUD 'I',1,'JONHY','JONHY@JONHY.COM','A';
--  EXECUTE   SP_CRUD 'I',2,'PETER','PETER@PETER.COM','A';
--  EXECUTE   SP_CRUD 'I',3,'DEREK','DEREK@DEREK.COM','A';

--  --TESTE
--  EXECUTE   SP_CRUD 'I',5,NULL,'JP@JP.COM','A';

--  --SELECT 
-- EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=4,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;

-- --UPDATE
-- EXECUTE SP_CRUD @V_OPER='A',@V_ID_PESSOA=4,@V_NOME='NUNO',@V_EMAIL='NUNO@NUNO.COM',@V_SITUACAO='A'

--  --SELECT 
-- EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=2,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;
-- --DELETE
-- EXECUTE SP_CRUD @V_OPER='D',@V_ID_PESSOA=4,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;
-- --EXEMPLO
-- EXECUTE SP_CRUD 'D',4,NULL,NULL,NULL


--  --SELECT 
-- EXECUTE SP_CRUD @V_OPER='S',@V_ID_PESSOA=2,@V_NOME=NULL,@V_EMAIL=NULL,@V_SITUACAO=NULL;


-- SELECT * FROM CAD_PESSOA