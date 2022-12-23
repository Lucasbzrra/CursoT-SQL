-- --Gatilhos Triggers 
-- triggers or Gatihos 
-- Um trigger é bloco de comandos Transact-SQL que é automaticamente executado quando um comando insert,
-- delet ou pdate for executado em uma tabela do banco de dados.

-- Os triggers são usados para realizar tarefas relacionadas com validações, restriões de acesso, rotinas 
-- de segurança e consistência de dados; desta forma estes controles deixam de ser executados 
-- pela aplicacao e passam a ser executadas pelos triggers em determinados situaçoes.

-- sintaxe: 
-- create TRIGGER [nome do trigger]
-- on [nome tabela ]
-- [for/after/instead of] [insert,update/delet]
-- as
-- --Corpo do trigger


-- FOR -- FOR é o valor padrão e faz com o que o gatilho seja disparado junto de ação.
-- AFTER ---Faz com que o disparo se dê somente após a ação que o gerou ser concluída.
-- INSTEAD OF --Faz com que o trigger seja executado no lugar da ação que o gerou.


USE CURSO
--DROP TABLE FUNC
CREATE TABLE FUNC (
 MATRICULA INT IDENTITY(1,1) PRIMARY KEY,
 NOME VARCHAR(30) NOT NULL,
 SOBRENOME VARCHAR (30) NOT NULL,
 ENDERECO  VARCHAR (30) NOT NULL,
 CIDADE    VARCHAR (30) NOT NULL,
 ESTADO    VARCHAR (2) NOT NULL,
 DATA_NASC  DATETIME
 ) ; 
insert into func values ('Steve','Morse','Rua 13','JUNDIAI','SP','1977-11-05')
insert into func values ('Joao','Pedro','Rua 14','SÃO PAULO','SP','1980-27-10')
insert into func values ('Maria','Clara','Rua 15','RIBERAO PRETO','SP','1985-05-05')
insert into func values ('Pedro','Luiz','Rua 16','CAMPINAS','SP','1990-12-09')

--SELECT * FROM FUNC
--DROP TABLE auditoria_salario
create table auditoria_salario (
matricula varchar(30) not null,
sal_antes decimal(10,2)  not null,
sal_depois decimal(10,2)  not null,
usuario varchar(20) not null,
data_atualizacao datetime not null
);

--DROP TABLE SALARIO
CREATE TABLE SALARIO 
( matricula INT NOT NULL,
  SALARIO DECIMAL(10,2) NOT NULL
  );

insert into SALARIO values (1,1000)
insert into SALARIO values (2,1500)
insert into SALARIO values (3,2000)
insert into SALARIO values (4,2500)

create trigger TG_aud_sal --unico registro
	on SALARIO 
		after UPDATE
	as
	Begin		
	
		declare @sal_antigo decimal(10,2)
		declare @sal_novo decimal(10,2)
		declare @matricula int
			
		select @matricula  = (select matricula from inserted)
		select @sal_antigo = (select SALARIO from deleted)
		select @sal_novo   = (select SALARIO from inserted)
							
	Insert into auditoria_salario 
	values 
	(@matricula, isnull(@sal_antigo,0), @sal_novo, SYSTEM_USER, getdate())
			
	end	
insert SALARIO set salario ='1200' where matricula='2'
--------------------------------------------------------------


create TABLE Conta_Corrente(
    conta_C VARCHAR(20) not null,
    valor DECIMAL(10,2) not null,
    operacao char(1) not null
)

create table saldo_conta(
    conta_c VARCHAR(20) not null,
    saldo decimal(10,2) not null
)

-------------------
create trigger TG_Saldo
on Conta_Corrente
FOR INSERT 
as 
    begin 
        declare @conta_c VARCHAR(20),
                @valor decimal(10,2),
                @oper CHAR(1)
        select @conta_c = I.conta_c,
                @valor= I.valor,
                @oper = I.operacao
        from inserted I 
if @oper not in ('D','C')
    begin 
        print 'Operação Não PERMITIDA'
        ROLLBACK TRANSACTION
    end 
ELSE if (select COUNT(*)
    from saldo_conta 
    where conta_c=@conta_c)=0
    and @oper = 'D'
    begin 
        insert into saldo_conta
        values (@conta_c,@valor *-1)
    end 
else if (select count(*)
        from saldo_conta 
        where conta_c =@conta_c)=0
        and @oper ='C'
        begin 
            insert into saldo_conta 
            values (@conta_c,@valor)
        end
else if (select COUNT(*)
        from saldo_conta
        where conta_c=@conta_c)>0
        and @oper = 'C'
        begin 
            UPDATE saldo_conta 
            set saldo = saldo + @valor
            where conta_c = @conta_c
        end 
else if (select COUNT(*)
        from saldo_conta
        where conta_c=@conta_c)>0
        and @oper ='D'
        begin 
            UPDATE saldo_conta
            set saldo=saldo-@valor
            where conta_c = @conta_c
        end 
    end

--Gatilho não permitre com este tipo de operação
insert into Conta_Corrente values (123,1500,'X')
--Testando
insert into Conta_Corrente values (123,1500,'C')
insert into Conta_Corrente values (123,3000,'D')

select * from Conta_Corrente 
select * from saldo_conta

--Criação de triggers que não permite a criação de tabelas e procedures
-- Em TODO DATABASE

---DISABLED TRIGGER trig_controle_dd1 on DATABASE
---drop  TRIGGER trig_controle_dd1 on database


create or alter TRIGGER trig_controle_dd1
on database 
for create_procedure, alter_procedure,drop_procedure,create_table,drop_table,alter_table 
as 
    if DATEPART(hh, GETDATE())>=8
        or DATEPART(hh,GETDATE())<=12
      begin 
        declare @msg VARCHAR(200)
        select @msg ='Complete o trabalho em horario comercial'
        print (@msg)
        ROLLBACK
      end 

------TESTANDO-------
create PROCEDURE proc_teste 
as 
    begin 
        print 'Teste de criaçao'
    end 

--Criação de triggers que não permite a criação de tabelas e procedures
-- Em TODO server
create or alter TRIGGER trig_controle_server
on all server  
for create_procedure, alter_procedure,drop_procedure,create_table,drop_table,alter_table 
as 
    if DATEPART(hh, GETDATE())>=8
        or DATEPART(hh,GETDATE())<=12
      begin 
        declare @msg VARCHAR(200)
        select @msg ='Complete o trabalho em horario comercial'
        print (@msg)
        ROLLBACK
      end 


------TESTANDO-------
create PROCEDURE proc_teste 
as 
    begin 
        print 'Teste de criaçao'
    end 


