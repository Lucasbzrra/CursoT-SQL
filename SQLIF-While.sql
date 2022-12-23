---Extensão SQL (t-sql)
-- As extensões sql permitem a criação de "scripts" poderosos e procedimentos armazenados (scripts armazenadaso )
-- no servidor e que podem ser reutilizados
-- Há diversas restrições relacionadas á criação de um script.
-- instruções de definição de dados create view, create procedure, create rule, create trigger e create default dever ser cada
---devem ser cadas uma a única instrução em um script

--As variávies são sempre identificadas em um batch através de um prefixo @.
--A atribuição de valores é feita usando-se:
--A forma especial da instrução select 
--A instrução SET
--Bloco de instuções: BEGIN (começa)  END (termina)
-- IF   --Aplicavel : Cursores,Funções,Procedures e Triggers.
--WHiLE --Aplicavel : Cursores,Funções,Procedures e Triggers.


if 1=1
begin 
print 'luqtea'
end  
else 
print 'oh no'

if 2=5 
print 'aqui'
else 
print 'teste'

--- Quando passa de uma linha e obrigatorio utilizar begin e end.
if 2=5
begin
select ('aqui')
select ('sas')
end 
else 
print 'teste'
print 'teste2'

use curso 
declare @idaluno int
set @idaluno='4';
if(select count(*)
    from matricula where id_aluno=@idaluno)=0
    begin 
        print 'Aluno sem matricula'
    end 
    else 
    begin 
    print 'Materia Matriculadas '
    select b.nome_disci, a.periodo from matricula a 
    inner join disciplina b 
    on a.id_disicplina = b.id_disciplina
    and a.id_aluno = @idaluno
    end 


--Estrutura WHILE
declare @cont int 
set @cont = 10
while (select getdate()-@cont)<=getdate()
      begin 
        print GETDATE()-@cont
        set @cont=@cont-1
        if (getdate()-@cont)>=getdate()
            break 
        else 
        CONTINUE
        end 


declare @num int=5,
        @num2 int=1 
while @num2<=10
    begin 
        print(cast(@num2 as varchar)+N'X'+CAST(@num as varchar)+N'='+CAST(@num2*@num as varchar))
       set @num2=@num2+1
    END



--Estrutura WHILE Exemplo 2
declare @v1 int=1,
        @v2 int=10 
while @v1<@v2 
    begin 
        if @v1%2=0
            begin 
                print cast(@v1 as varchar)+' Parr'
                set @v1=@v1+1
            end
        else 
            begin 
                print cast(@v1 as varchar)+N' Impar'
                 set @v1=@v1+1
            end 
    end

--Try catch Tratamentos erros

begin try 
    select 1/0;
end try 
begin catch 
    select 
        ERROR_LINE() as erroline,
        ERROR_MESSAGE() as errormensagem,
        ERROR_NUMBER() as errosnumero,
        ERROR_SEVERITY() as errorsenventia,
        ERROR_STATE() as errorstate,
        ERROR_PROCEDURE() as errorprocedura
end CATCH
go 
