--JOINS EXEMPLOS
use curso

create table alunos
(
    id_aluno int identity(1,1),
    nome varchar(20) not null

)
create table disciplina(
    id_disciplina int IDENTITY(1,1),
    nome_disci varchar(20)
)
CREATE table matricula(
    id_aluno int ,
    id_disicplina int,
    periodo varchar(10)
)  
ALTER TABLE matricula alter COLUMN id_aluno int not null;

alter table matricula alter column id_disicplina int not null;

--PRIMARY compost 
alter table matricula add constraint PK_1 PRIMARY key (id_aluno, id_disicplina);

alter table disciplina add constraint PK2 PRIMARY key (id_disciplina)

alter table alunos add CONSTRAINT pk1 primary key (id_aluno)

alter table matricula 
add CONSTRAINT fk_mat foreign key (id_aluno) REFERENCES alunos(id_aluno)

alter table matricula 
add constraint fk_mat2 foreign key (id_disicplina) REFERENCES disciplina(id_disciplina)

insert into alunos(nome) values ('james');
insert into alunos(nome) values ('hilbert');
insert into alunos(nome) values ('henrique');
insert into alunos(nome) values ('tigao');
insert into alunos(nome) values ('thao');

SELECT * from alunos

insert into disciplina(nome_disci) values ('fisica')
insert into disciplina(nome_disci) values ('quimica')
insert into disciplina(nome_disci) values ('matematica')
insert into disciplina(nome_disci) values ('banco de dados')
insert into disciplina(nome_disci) values ('Programacao')

SELECT * from disciplina

insert into matricula values('1','1','Noturno')

insert into matricula values('1','2','Vespertino')

insert into matricula values('1','3','Matutino')

INSERT into matricula values ('2','3','noturno')
INSERT into matricula values ('2','4','noturno')

insert into matricula values('3','1','noturno')
insert into matricula values('3','3','noturno')
insert into matricula values('3','4','noturno')

insert into matricula values('5','1','maturino')
insert into matricula values('5','2','vespetino')
insert into matricula values('5','4','noturno')

SELECT * from matricula
-- SET IDENTITY_INSERT alunos off;  
-- GO  


---iner join 
select a.id_aluno,
       a.nome,
       c.id_disciplina,
       c.nome_disci,
       b.periodo
    FROM alunos a
    inner join matricula b
    on a.id_aluno = b.id_aluno
    inner join disciplina c
    on b.id_disicplina = c.id_disciplina


--left join 

select a.id_aluno,
       a.nome,
       c.id_disciplina,
       c.nome_disci,
       b.periodo
    FROM alunos a
    left join matricula b
    on a.id_aluno = b.id_aluno
    left join disciplina c
    on b.id_disicplina = c.id_disciplina


--right join
select a.id_aluno,
       a.nome,
       c.id_disciplina,
       c.nome_disci,
       b.periodo
    FROM alunos a
    right join matricula b
    on a.id_aluno = b.id_aluno
    right join disciplina c
    on b.id_disicplina = c.id_disciplina

--full join
    select a.id_aluno,
       a.nome,
       c.id_disciplina,
       c.nome_disci,
       b.periodo
    FROM alunos a
    full join matricula b
    on a.id_aluno = b.id_aluno
    full join disciplina c
    on b.id_disicplina = c.id_disciplina


use crm 

select * from carro_cliente

select a.id_cliente,
       a.primeiro_nome,
       a.codigo_pais,
       b.ano,
       c.nome_carro,
       d.nome_montadora
       from cliente a 
       
       inner join carro_cliente b 
       on b.id_cliente =a.id_cliente

       inner join carro_montadora c 
       on c.id_carro = b.id_carro

       inner join montadora d 
       on c.id_montadora = d.id_montadora


use AdventureWorks2017
select * from Person.Person

select a.BusinessEntityID,
       a.LastName,
       a.FirstName,
       a.PersonType,
       b.JobTitle
     from Person.Person a
     inner join HumanResources.Employee b 
     on b.BusinessEntityID = a.BusinessEntityID



--right join --Direita--


select a.BusinessEntityID,
       a.LastName,
       a.FirstName,
       a.PersonType,
       b.JobTitle
     from Person.Person a
     right join HumanResources.Employee b 
     on b.BusinessEntityID = a.BusinessEntityID

--left join  

select a.BusinessEntityID,
       a.LastName,
       a.FirstName,
       a.PersonType,
       b.JobTitle
     from Person.Person a
     left join HumanResources.Employee b 
     on b.BusinessEntityID = a.BusinessEntityID


--full join 

select a.BusinessEntityID,
       a.LastName,
       a.FirstName,
       a.PersonType,
       b.JobTitle
     from Person.Person a
     full join HumanResources.Employee b 
     on b.BusinessEntityID = a.BusinessEntityID

