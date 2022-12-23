create database DB_Lgpd
go

use DB_Lgpd

create TABLE Cliente(
    id_cliente int IDENTITY PRIMARY key,
    Primeiro_nome VARCHAR(100) MASKED with (FUNCTION = 'partial(1,"XXXXXXX",0)') not NULL,
    Ultimo_nome VARCHAR(100) not null,
    Telefone VARCHAR(12) MASKED WITH (FUNCTION='default()') null,
    Email VARCHAR(100) MASKED with (FUNCTION='email()')null,
    Cartao_Credito VARCHAR(20) not null,
    salario DECIMAL(10,2) not null
)

insert Cliente VALUEs ('Andre', 'Rosa', '555.123.4567', 'andrer@teste.com','1111-2222-3333-4444',12000),  
('Pedro', 'Silva', '555.123.4568', 'pedros@teste.com','1234-4321-9632-7411',9000),  
('Mariana', 'Souza', '555.123.4569', 'marianas@teste.net','1234-4321-9632-7411',15000);  

select * from Cliente

--Criação de role para acesso 
create role vendedores_com_acesso
create role vendedores_sem_mas
create role vendedores_sem_acesso

--criaçao users teste

create user James WITHOUT login;
create user Paulo WITHOUT login;
create user Oliver WITHOUT login;

--Adcionando users as respectivas acessos (roles)
exec sp_addrolemember 'vendedores_com_acesso', 'James';

exec sp_addrolemember 'vendedores_sem_mas', 'Oliver';

exec sp_addrolemember 'vendedores_sem_acesso', 'Oliver';

--Concedendo acesso a role de leitura 

grant select on Cliente to vendedores_com_acesso

GRANT unmask to vendedores_sem_mas

--Nega acesso a role

DENY select on Cliente to vendedores_sem_acesso

--teste de acesso 
execute as user ='Oliver'
select * from Cliente;
revert 

--Identificando os campos com mascara
select c.name, tbl.name as TABLE_name, c.is_masked, c.masking_function
from sys.masked_columns as c 
join sys.tables as tbl 
    on c.object_id=tbl.object_id
where is_masked=1;

--ADICIONAR MASCARA NA TABELA EXISTENTE
--
--MASCARA  ULTIMO NOME
alter table Cliente alter COLUMN Ultimo_nome add masked WITH (FUNCTION = 'partial(2,"XXXXXXX",0)')

EXECUTE AS USER = 'Oliver';  
SELECT * FROM CLIENTE;  
REVERT; 