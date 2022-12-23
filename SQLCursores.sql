--Cursores 
use curso
declare @minhavariavel VARCHAR(100)

declare meucursor
cursor local for select nome from alunos 
open meucursor
FETCH next from meucursor into @minhavariavel
while (@@FETCH_STATUS=0)
    begin 
    print @minhavariavel +'fetchstatus->'+cast(@@FETCH_STATUS as varchar (10))
    fetch next from meucursor into @minhavariavel 
end 
print 'fetchstatus->'+cast(@@FETCH_STATUS as varchar(10))
close meucursor

deallocate meucursor


--CURSORES UTILIZANDO UPDATE
use curso
select a.businessEntityID codpessoas,
       a.FirstName nome,
       a.LastName sobrenome,
       cast('' as varchar(100)) nomecompleto
       into clifor 
from AdventureWorks2017.person.person a 

select * from clifor

ALTER table clifor add CONSTRAINT pk PRIMARY key (codpessoas)

declare @codpessoa int,
        @primeironome VARCHAR(50),
        @sobrenome VARCHAR(50),
        @nomecompleto varchar(100)

declare cursor1 cursor for 
select codpessoas,
        nome,
        sobrenome
from clifor 

open cursor1 

fetch next from cursor1 into @codpessoa, @primeironome, @sobrenome

WHILE @@FETCH_STATUS=0
begin 
    UPDATE clifor
    set nomecompleto=@primeironome+''+@sobrenome
    where codpessoas = @codpessoa

    fetch next from cursor1 into @codpessoa,@primeironome,@sobrenome
end

close cursor1

deallocate cursor1

select * from clifor


------
use curso 
create table cli_nome(
    cod_cliente int PRIMARY key not NULL,
    nomecompleto varchar(100) not null
)

declare @codcliente int,
        @priemironome varchar(30),
        @sobrenome varchar(60),
        @nomecompleto varchar(90)

declare cursor1 cursor for 
select a.businessentityId, a.firstname, a.lastname from AdventureWorks2017.Person.Person a 

open cursor1

FETCH next from cursor1 into @codcliente,@priemironome,@sobrenome

while @@FETCH_STATUS=0
begin 
    set @nomecompleto = @primeironome+''+@sobrenome
    insert into cli_nome values (@codcliente, @nomecompleto);

fetch next from cursor1 into @codcliente, @primeironome,@sobrenome end 

close cursor1

deallocate cursor1

-----Cursores 3
create table Contapagparc (
    num_doc int,
    dtvenc date,
    parcela int 
)
select num_doc,dtvenc from Contapagparc
select * from Contapagparc

insert into Contapagparc values ('1',getdate()+30,''),
                                ('1',getdate()+45,''),
                                ('1',getdate()+60,''),
                                ('2',getdate()+15,''),
                                ('2',GETDATE()+20,''),
                                ('2',GETDATE()+25,'')


declare @numdoc as int 
declare @dtvenc as date 
declare @cont as int = 0
declare @numdocaux as int 
declare cursorparc  cursor for 
select num_doc,
          dtvenc
from Contapagparc
order by num_doc, dtvenc asc 

open cursorparc 
fetch next from cursorparc into @numdoc, @dtvenc
while @@FETCH_STATUS = 0
    begin 
        if @numdocaux <>@numdoc
            begin 
             set @cont=1;
             set @numdocaux = @numdoc
            end
        else 
            begin 
            set @cont=@cont + 1
            set @numdocaux = @numdoc
        end
update Contapagparc
set parcela = @cont
where num_doc = @numdoc
and dtvenc = @dtvenc;

FETCH next from cursorparc into @numdoc,@dtvenc
end 
close cursorparc 
DEALLOCATE cursorparc

select * from Contapagparc

--------- Outros cursores 
create table ##Dados(
    numero int null,
    nome varchar(20)
)
insert into ##Dados values (1,'Jack'),
                           (2,'Peter'),
                            (3,'Sam'),
                            (4,'Malcon'),
                            (5,'David'),
                            (6,'Greg'),
                            (7,'Jorge'),
                            (8,'Richard'),
                            (9,'Marlos'),
                            (10,'Anne')

declare cDados scroll cursor for 
select numero,nome from ##Dados
open cDados
select @@CURSOR_ROWS
--Primeiro registro do cursor
fetch absolute 1 from cDados
--Próximo registro
FETCH next from cDados
--último registro
fetch last from cDados
--Retornar a linha anterior ao registro atual do cursor 
fetch prior from cDados
--Volta para a segunda linha do cursor 
fetch absolute 2 from cDados
--Avanca tres registros em relação ao registro atual 
fetch relative 3 from cDados
close cDados 
deallocate cDados

---Cursor com outro cursor embutido

use curso 
declare @idaluno int,
        @nome VARCHAR(30),
        @nomedisciplina VARCHAR(30),
        @periodo VARCHAR(10)
--Declarando primeiro cursor
declare c_alunos cursor FOR
select id_aluno,
       nome 
from alunos 

open c_alunos 
fetch next from c_alunos into @idaluno, @nome

--Repeticao priemiro crusos 
WHILE @@FETCH_STATUS = 0
    begin 
        print 'Nome aluno: '+@nome
        print 'Disciplinas:';

    --Declrando segundo cursos
    declare c_disciplinas cursor for 
    select b.nome_disci,
            a.periodo
    from matricula a 
        INNER join disciplina b 
                on a.id_disicplina=b.id_disciplina
        where a.id_aluno = @idaluno
    OPEN c_disciplinas 

    fetch next from c_disciplinas into @nomedisciplina,@periodo
    --Repeticao segundo cursor
    while @@FETCH_STATUS = 0
    begin 
        print @nomedisciplina
        FETCH next from c_disciplinas into @nomedisciplina, @periodo
        --Fechando repeticao segundo cursor 
    end 
    close c_disciplinas
    DEALLOCATE c_disciplinas
    print '-----------------';
    FETCH next from c_alunos into @idaluno,@nome
    --Fechando repeticao primeiro cursor
    end 
close c_alunos
DEALLOCATE c_alunos