--RESTAUARAR UM BANCO DE DADOS COM MDF E LDF

--ESTE COMANDO PARA VÊ COMO ESTÂO NOMES DO ARQUIVOS 
RESTORE FILELISTONLY
            FROM DISK = 'C:/Program Files/Microsoft SQL Server/MSSQL15.MSSQLSERVER/MSSQL/Backup/AdventureWorks2012.bak'
GO


---------------

RESTORE DATABASE AdventureWorks2012
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\AdventureWorks2012.bak'
   WITH MOVE 'AdventureWorks2012' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\AdventureWorks.mdf',
        MOVE 'AdventureWorks2012_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\AdventureWorks_log.ldf'
GO