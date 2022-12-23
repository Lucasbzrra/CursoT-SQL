---EXTERNSÂO MERGER 


--Realiza operações de inserção, atualização ou exclusão em uma tabela de destino base com base nos resultados da junção
--com a tabela de origem. Por exemplo, você pode sincronizar duas tabelas inserindo, atualizando ou excluindo linha em 
--com base nas diferenças encontradas na outra tabela 

---INTO <target_table>-- Define a tabela ou view que será a fonte de destino 
--AS 
--USING <table_source>-- Define a tabela ou view que será fonte de origem, baseado na codição de merge da tabela
--ON <merger_search_Condition>-- Define as condições de join da tabela destino com a tabela origem 
--WHEN MATCHED THEM ---Define a ação a ser realizada quando há linha na fonte de destino origem que correspondem com a fonte d
--Origem
--WHEN NOT MATCHED [BY TARGET] THEN-- Define a açaõ a ser realizada quando não há linha da fonte de origem 
--que correspondem com a fonte de origem 
--WHEN NOT MATCHED BY SOURCE THEN-- Define a ação a ser realizada quando há linhas na frente na fonte de destino,
--Mas não há linhas correspondentes na fonte de origem.

create table #tabela(
    nome VARCHAR(100),
    cadastro DATETIME,
    alteracao DATETIME,
    situacao bit
)
insert #tabela values('jack',GETDATE(),null,1),
                     ('peter',GETDATE(),null,1),
                     ('john',GETDATE(),null,1),
                     ('malcon',GETDATE(),null,1),
                     ('arthur',GETDATE(),null,1)

create table #tabela2(nome varchar (100),
                     email varchar(100))

INSERT #tabela2 values ('jack','jack@jake.com'),
                      ('peter','peter@peter.com'),
                      ('john','john@jonh.com'),
                      ('malcon','malcon@mail.com.'),
                      ('richard','richard@richar.com')

select * from #tabela
select * from #tabela2


--INICIO DO MERGER

merge #tabela as destino 
using #tabela2 as origem 
on destino.nome =origem.nome

--Há registro no destino e na origem

WHEN MATCHED 

THEN UPDATE SET situacao =0, alteracao=getdate()

--Quando não há registro  no destino e há origem

WHEN NOT MATCHED 

THEN INSERT (nome,cadastro,alteracao,situacao) values (origem.nome,GETDATE(),GETDATE(),1)

--Quando há registro no destino mas não há na origem

WHEN NOT MATCHED BY SOURCE 

THEN UPDATE SET   situacao=null,alteracao = GETDATE();  

--Verificando resultado
select *from #tabela
select *from #tabela2


--EXEMPLO TWO
use curso 

create table produtos(
    cod_prod int PRIMARY key,
    descricao varchar(100),
    preco money 
)
insert into produtos values(1,'cha',10.00),
                            (2,'cafe',20.00),
                            (3,'leite',30.00),
                            (4,'pao',40.00)
insert into produtos values(6,'acucar',10.00)

create table produtos_atualizados (
    cod_prod int primary key,
    descricao VARCHAR(100),
    preco money
)
insert into produtos_atualizados values(6,'sal',10.00)

insert into produtos_atualizados values(1,'cha',10.00),
                                       (2,'cafe',25.00),
                                       (3,'leite',35.00),
                                       (5,'peixe',60.00)
select * from produtos
SELECT * from produtos_atualizados

--Merger SQL declaraçao

merge produtos as destino 
using produtos_atualizados as origem 
on (destino.cod_prod =origem.cod_prod)

--Há registro no destino e na origem 

when MATCHed and destino.descricao <>origem.descricao 
or destino.preco <> origem.preco then 
UPDATE set destino.descricao = origem.descricao,
destino.preco =origem.preco

--Quando não há registro no destino e há na origem

when not matched by target then 
insert (cod_prod,descricao,preco) values(origem.cod_prod,origem.descricao,origem.preco)

--Quando há registro no destino mas não há na origem 

when not matched by source then 
delete 

--$action especifica coluna nvarhcar(10)
--Output retorna a informações ou expressões baseadas 
--em cada linha afetada por uma instrução insert, update,delete ou merge

OUTPUT $action,
DELETEd.cod_prod as destino_cod_prod,
DELETEd.descricao as destino_descricao,
deleted.preco as destino_preco,
inserted.cod_prod as origem_cod_prod,
inserted.descricao as origem_descricao,
inserted.preco as origem_epreco ;
select @@ROWCOUNT
go 

select * from produtos
select * from produtos_atualizados


---------------------------


--Exemple 

if object_id('dbo.Jogos','U') is not null
drop TABLE dbo.Jogos
create table Jogos(
    IdJogo int,
    Nome VARCHAR(100),
    Preco decimal(10,2)
    CONSTRAINT primeira PRIMARY key (IdJogo)
) 

insert into dbo.Jogos VALUES (1,'Uncharted',250.00),
                              (2,'TombRaider',150.00),
                              (3,'RDR2',70.00);


if OBJECT_ID('dbo.Preco','U')is not NULL
drop TABLE dbo.Preco 
create table Preco(
    IdJogo int,
    Nome varchar(100),
    Preco DECIMAL(10,2)
    CONSTRAINT segunda PRIMARY key (IdJogo)

)

insert into dbo.Preco values(1,'Uncharted',170.00),
                            (2,'TombRaider',100.00),
                            (3,'RDR2',20.00);

select * from Jogos
select * from dbo.Preco

-- UTILIZANDO O MERGER 

merge dbo.Jogos as destino 
USING dbo.Preco as origem 
on (destino.IdJogo =origem.IdJogo)

--Quando há registro na origem é no destino

when MATCHed THEN
update set destino.Preco =origem.Preco


--Quando não há resgitro no destino, é  há na origem
when not matched  then 
insert values (origem.IdJogo,origem.Nome,origem.Preco)

---Verificar o resgistros antigo 

OUTPUT $action,
inserted.*;

select * from Jogos
select * from dbo.Preco


create TABLE Testeinset(
    id int,
    nome VARCHAR(100)
    CONSTRAINT primeiro PRIMARY key(id)
);

insert into Testeinset(id,nome) OUTPUT INSERTED.*
values(1,'lucas')

-- OUTPUT $action

--------------------------------------
--Exmple
--------------------------------------

if OBJECT_ID('dbo.produtos','U')is not null 
drop table dbo.produtos
create table produtos(
    Id int,
    nome VARCHAR(100),
    valor decimal(10,2)
    CONSTRAINT pri PRIMARY key (Id)
);

if OBJECT_ID('dbo.produtosatualizados','u')is not NULL
drop TABLE dbo.produtosatualizados
create table produtosatualizados(
     Id int,
    nome VARCHAR(100),
    valor decimal(10,2)
     CONSTRAINT p2 PRIMARY key (Id)
);


select* from produtosatualizados
select * from produtos

insert into produtos values (1,'Cavia',150.00),
                            (2,'Fralda',30.99),
                            (3,'Bife',24.99);

insert into produtosatualizados values (1,'WHISK',1500),
                                        (3,'Cavalo',2000),
                                        (7,'Frezzer',7000);


MERGE dbo.produtos as  destino 
USING dbo.produtosatualizados as origem 
on( destino.id = origem.id)

-- when MATCHed  and destino.nome <> origem.nome or destino.valor <>origem.valor 
-- then update set destino.nome = origem.nome, destino.valor=origem.valor

when not matched by target then 
insert (Id,nome,valor) values (origem.Id,origem.nome,origem.valor);

-- WHEN not matched by source then 
-- DELETE;

