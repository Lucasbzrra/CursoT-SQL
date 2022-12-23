--Funções de cadeia de caracteres 

--EXEMPLO
select ASCII('SQL')
select ASCII('S')
select ASCII('Q')
select ASCII('L')

declare @position int,
        @string CHAR(5);
        set @position =1
        set @string = 'teste';
        while @position <= LEN(@string)
            begin 
              select ASCII(SUBSTRING(@string,@position, 1)) codascci,
              CHAR(Ascii(substring(@string,@position, 1)))
              set @position = @position +1
            end;


--LTrim  retornar um expressção de caractere depois remove espaços em branco a esquerda.

declare @string varchar(60);
set @string = '      <-Espaço a Esquerda';
select 'Texto sem espaco: ' + LTRIM(@string);
SELECT 'Texto com espaço'+@string;

--STR retornar dados caracteres convertidos de dados númericos 

select str(123.45,70)
--Provando que foi convertido numerico para string 
select 'Teste'+str(155)
--Erro logico 
SELECT 'teste'+155


--CONCAT Retorna uma cadeia de caracteres que é o resultado da concatenaçao de dois ou mais valores

select CONCAT(CURRENT_USER,
' Seu saldo e R$ ',
128 ,
' Em ',
DAY(GETDATE()),'/',
MONTH(getdate()),'/',
YEAR(GETDATE())) as result
--SIMULANDO ERRO NÂO PODE SSER UTILIZADO O + PADRÂO EM CONCAT

select CONCAT(CURRENT_USER,
' Seu saldo e R$ '+
128 +
' Em '+
DAY(GETDATE())+'/'+
MONTH(getdate())+'/'+
YEAR(GETDATE())) as result

--CONCAT_WS 
--Separa e retornar valores de cadeia de caracteres concatenados com o delimitador especificado
--no argumento da primeira funcao
-- ATENÇÂO IGNORA VALORES NULL
use crm 
select top(10) CONCAT_WS(' | ',a.primeiro_nome,a.ultimo_nome,a.email,a.nascimento,sexo)
from cliente a 


-- ATENÇÂO IGNORA VALORES NULL 
--Pode se observar que na linha 9
use curso 
select CONCAT_WS(' | ',a.id_aluno,a.nome,id_disicplina,b.periodo,c.nome_disci)    from alunos a 
left join matricula b 
on b.id_aluno = a.id_aluno
left join disciplina c 
on b.id_disicplina = c.id_disciplina

--Melhorando o codigo 

use curso 
select CONCAT_WS(' | ',a.id_aluno,a.nome,
isnull(b.id_disicplina,''),
ISNULL(b.periodo,' SEM '),
isnull(c.nome_disci, '') )   from alunos a 

left join matricula b 
on b.id_aluno = a.id_aluno
left join disciplina c 
on b.id_disicplina = c.id_disciplina



--Replace substitui todas ocorrências de um valor de cadeia de caracteres especificando por outro valor de cadeia de caracteres 
select REPLACE('kjndf', 'kj','TT') pr

select 'VinatgeCil' as aqui,
REPLACE('VinatgeCil','vin','XXX') teste

select top(10)* from regiao

--Uitlizando em tabelas 
use curso
select regiao,
REPLACE(regiao,'Sul','South')
from regiao


create table pessoas(
    nome VARchar(30)
)

insert into pessoas values ('Lucas'),
                            ('Oliver'),
                            ('hILBERT')
                            
select * from pessoas
update pessoas set nome  =REPLACE(nome,'R','XXX')


--Replicate
--Repete um valor da cadeia de caracteres um número especificado de vezes 

use AdventureWorks2017 
select name,
        ProductLine,
        REPLICATE('0',4)+ ProductLine as codigoreplicado 
    from Production.Product
    where ProductLine = 'T'
    ORDER by Name

--Left retrina a parte da esquerda de uma cadeia de caracteres com o número especificado
use AdventureWorks2017
select name,
      left(name,10) as veja
from Production.Product
order by ProductID

--SUBSTRING 
--Retorna uma substring de caractere com dados de caractere dentro parâmentro informando 

select lastname,
        SUBSTRING(lastname,1,4) as priemrio,
        SUBSTRING(lastname,4,8) as segunda 
from Person.Person
order by LastName asc 

--Reverse
--Retorna a ordem inversa de um valor de cadeia de caractere 

select firstname,
        REVERSE(firstname) as revertido 
from Person.Person
where Person.BusinessEntityID <5

--LEN 
--Retorna o número de cadeia de caracteres da expressão 
--Exlucindo o espaço da direita 

select firstname,
        LEN(firstname) as tamanho
from Sales.vIndividualCustomer
where CountryRegionName in (  'Australia')


--DATALENGTH
--retorna o número de bytes para representar qualquer expressão

select name,
       dATALENGTH(name) as teste
from Production.Product
order by teste

--REIGHT

--Retorna a parte da direita de um cadeia de caracteres com um número de caracteres especificado

use curso
select estado,
        RIGHT(estado, 5 ) as 'Esyado'
from regiao 
 
