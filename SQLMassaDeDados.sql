-- BULK INSERT (Massa de Dados de outros arquivos como :xlx é txt) 

-- Podemos usar comando bulk insert do sql server para copiar (importar) dados de um arquivo texto ou nativo do sql server (Também chamados de flat file).
-- É o modo mais rápido de importar dados; porém somente trabalha em um direção e com tipo de arquivo: flat file 


if OBJECT_ID('dbo.#Produto','u') is not NULL
drop TABLE dbo.#Produto
CREATE TABLE #Produto(
    id int,
    nome VARCHAR(1000)
);

BULK insert dbo.#Produto 
from 'C:\Bulk\produto.txt'
with
(    codepage='acp', --ACP--OEM--RAW--CODE_page-- (Define a página de códigos a ser usada na importação, e, por consequência, se os caracteres vêm acentuados ou não)
     datafiletype = 'widechar',--CHAR|NATIVE|widechar|widenative
     fieldterminator ='|', -- '|'--','--';'--':' (Caractere Usado para separa um coluna da outra)
     rowterminator ='\n',---\n --\t --\r-- (Caractere usado para separar uma linha)
     maxerrors=0,--(Define a quanntidade de rros que pode ocorrer numa importação de dados)
     fire_triggers,--(Se informando, dispara as triggerss na execução do comando)
     firstrow=1,--(Define qual será a primeira linha importada)
     lastrow=5--(define quyal será a última linha importada)
     --KEEP_IDENTITY (Se informando, dispara as triggers na execução do comando)
);

select * from dbo.#Produto

drop table dbo.#Produto

select * from sys.servers

declare @num int=10,
        @i int=1,
        @divi int=0;

while @num>@i
begin 
    if (@num % @i=0)
    begin 
        print(@num)
        set @divi=@divi+1
    end 
    set @i=@i+1
end 

if (@num=2)
    begin 
    print('foi ')
    end 