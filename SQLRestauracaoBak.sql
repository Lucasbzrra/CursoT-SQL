-- -- --Backup do Banco de Dados e Restauração 
-- -- --IMPORTANTE USAR EXTERNSÂO DO .bak
use testcampoCalculado
 go 
 backup DATABASE testcampoCalculado
 to disk = 'D:\BackpBancoDados\testcampoCalculado.bak'
 with FORMAT;
go
-- -- --APAGANDO BACKUP 
 DROP DATABASE testcampoCalculado

-- -- --RESTAURANDO BACKUP VIA COMANDO SQL
 use master 
 restore database testcampoCalculado from disk =  'D:\BackpBancoDados\testcampoCalculado.bak'

-- -- Diretorio de bak, onde devem ficar 
C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup---

-- -- Restaurar em forma de codigo segunda forma caso apresente erros, terá move
RESTORE FILELISTONLY 
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\curso.bak'
 GO

 RESTORE DATABASE teste
 FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\curso.bak'
 WITH MOVE 'curso' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\curso.MDF', 
 MOVE 'curso_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\curso_Log.LDF'

 ALTER DATABASE teste MODIFY NAME = curso;
