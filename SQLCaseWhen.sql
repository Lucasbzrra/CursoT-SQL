
    --Estrutura case WHEN
use curso 
declare @data date 
set @data =GETDATE()+1
select @data,
 case when @data= GETDATE() then 'Hoje'
      when @data< GETDATE() then 'Ontem'
      when  @data > GETDATE() then 'Amanhã'
end dia  





use AdventureWorks2017
select Productnumber,
       productline,
       case 
       when productline = 'R' then 'Road'
       when productline = 'M' then 'Road'
       when productline = 'T' then 'Road'
       else 'Not For Sale' end categoria,
       name 
from Production.Product
ORDER by ProductNumber



select productnumber,
       name,
       listprice,
       case when listprice = 0 then 'Não está a venda'
       when listprice <=50 then 'Abaixo de $50'
       when listprice >50 and listprice <=250 then 'Entre 51 e 251'
       when listprice >250 and listprice <=1000 then 'Entre que 251 de 1000'
       else 'Acima de 1000' end rannger,
       'produtos' as categoria
    from Production.Product
    order by ProductNumber


--Ordenando com case WHEN

select BusinessEntityID,
SalariedFlag
from HumanResources.Employee
order by case when SalariedFlag = 1 then BusinessEntityID end desc,
         case when SalariedFlag = 0 then BusinessEntityID end asc 


--Update com case when 
begin TRANSACTION a1 
use AdventureWorks2017
go

UPDATE HumanResources.Employee
set VacationHours = (case when ((VacationHours -10.00)<0) then VacationHours + 40.00
else (VacationHours + 20.00)end )

--Realizando print dos campos atualizado
--ESTRUTURA 
-- output deleted.(Registros deletados) -- primeiro aponta o id da tabela
--  deleted.(Registros deletados) -- agora mostra o registros deletados
-- inserted.(registros inseridos)


OUTPUT deleted.BusinessEntityID, 
deleted.VacationHours as antes,
inserted.VacationHours as depois
where SalariedFlag = 0;

ROLLback TRANSACTION a1


--------
use curso
select distinct a.id_aluno, a.nome, ISNULL(b.periodo,'vazio') 
from alunos a
left join matricula b 
on a.id_aluno=b.id_aluno




