---ETL
use master;

create database dump_dw_project
GO


use dump_dw_project
go

select*from BeneficiosSocialesPorDeciles

select*from BeneficiosSocialesPorEdad

select*from BeneficiosSocialesPorEducacion

select*from BeneficiosSocialesPorEmpleo

SELECT * FROM dbo.BeneficiosSocialesPorSexo;

SELECT * FROM dbo.BeneficiosSocialesPorSituacionVivienda;

SELECT * FROM dbo.[Beneficios-S-x-SE_2023];

SELECT * FROM dbo.EducacionPorEdad;

SELECT * FROM dbo.EducacionPorSexo;

SELECT * FROM dbo.EmpleoPorEdad;

SELECT * FROM dbo.EmpleoPorSexo;

SELECT * FROM dbo.[Inv-Social-x-instituciones];

SELECT * FROM dbo.ProgramasSocialesPorProvincia;

SELECT * FROM dbo.SituacionSocialPorDeciles;

SELECT * FROM dbo.SituacionSocioeconomicaPorEdad;

SELECT * FROM dbo.SituacionSocioeconomicaPorSexo;

SELECT * FROM dbo.SituacionSocioeconomicaPorVivienda;

SELECT * FROM dbo.SituacionViviendaPorDecil;

SELECT * FROM dbo.SituacionViviendaPorEmpleo;

SELECT * FROM dbo.[Estadisticas 2020];

SELECT * FROM dbo.[Estadisticas Policiales 2021];

SELECT * FROM dbo.[Estadisticas 2022];

SELECT * FROM dbo.[Estadisticas 2023];

SELECT * FROM dbo.[Estadisticas 2024];
