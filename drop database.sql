use master
GO

drop DATABASE dump_dw_project
go

DROP DATABASE dw_datamart
GO

DROP DATABASE dw_project_normalized
GO

CREATE DATABASE dump_dw_project
GO

USE master;
ALTER DATABASE dw_project_normalized SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dw_project_normalized;



