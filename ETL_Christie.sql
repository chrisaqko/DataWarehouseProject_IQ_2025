-- QUERY TRANSFORMACION DE DATOS
SELECT * FROM dbo.[Beneficio-social-x-sexo_2023]

SELECT * FROM dbo.[Beneficios-S-x-SE_2023]

SELECT * FROM dbo.[Beneficios-social-x-edad_2023]

SELECT * FROM dbo.[Beneficios-sociales-x-deciles_2023]

SELECT * FROM dbo.[Beneficios-sociales-x-Educacion_2023]

SELECT * FROM dbo.[Beneficios-sociales-x-Educacion_2023]

SELECT * FROM dbo.[Beneficios-sociales-x-empleo_2023]

SELECT * FROM dbo.[Beneficios-sociales-x-Situacion-Vivienda_2023]

SELECT * FROM dbo.[Educacion-x-edad_26-8-24]

SELECT * FROM dbo.[Educacion-x-sexo_26-8-24]

SELECT * FROM dbo.[Empleo-x-Sexo_21-8-24]

SELECT * FROM dbo.[Estadísticas Policiales 2020]

SELECT * FROM dbo.[Estadísticas Policiales 2021]

SELECT * FROM dbo.[Estadísticas Policiales 2022]

SELECT * FROM dbo.[Estadísticas Policiales 2023]

SELECT * FROM dbo.[Estadisticas Policiales 2024]

SELECT * FROM dbo.[Empleo-x-Edad_26-8-24]

SELECT * FROM dbo.[Inv-Social-x-instituciones]

SELECT * FROM dbo.[Programa-sociales-x-provincia]

SELECT * FROM dbo.[SS-x-Vivienda_21-8-24]

SELECT * FROM dbo.[SSxDeciles_21-8-24]

SELECT * FROM dbo.[SSxEdad_21-8-24]

SELECT * FROM dbo.[SSxSexo_9-7-24]

SELECT * FROM dbo.[Svivienda-x-decil_21-8-24]

SELECT * FROM dbo.[Svivienda-x-empleo_21-8-24]

-------------- 

select distinct Provincia from  dbo.[Estadisticas Policiales 2024]
GO

update dbo.[Estadisticas Policiales 2024] set Provincia = 'DESCONOCIDO'
where Provincia IS NULL

CREATE PROCEDURE InsertarProvincias
AS
BEGIN
    -- Insertar los valores distinct de Provincia en la tabla dimension_Provincia
    INSERT INTO dw_project_normalized.dbo.dimension_Provincia (nombre_provincia)
    SELECT DISTINCT Provincia
    FROM dbo.[Estadisticas Policiales 2024]; -- Opcional: evita insertar valores NULL
END
GO

EXEC InsertarProvincias;
GO


----------------
SELECT Cantón, COUNT(*)
FROM dbo.[Estadisticas Policiales 2024]
GROUP BY Cantón
HAVING COUNT(*) > 1
GO

select distinct Cantón from  dbo.[Estadisticas Policiales 2024]
GO

update dbo.[Estadisticas Policiales 2024] set Cantón = 'DESCONOCIDO'
where Cantón IS NULL
GO


CREATE PROCEDURE InsertarCantonesSanJose
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 9
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'SAN JOSÉ' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 9
    );
END
GO

CREATE PROCEDURE InsertarCantonesLimon
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 10
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'LIMÓN' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 10
    );
END
GO

CREATE PROCEDURE InsertarCantonesDesconocido
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 11
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia IS NULL OR Provincia = 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 11
    );
END
GO

CREATE PROCEDURE InsertarCantonesPuntarenas
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 12
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'PUNTARENAS' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 12
    );
END
GO

CREATE PROCEDURE InsertarCantonesGuanacaste
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 13
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'GUANACASTE' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 13
    );
END
GO

CREATE PROCEDURE InsertarCantonesCartago
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 14
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'CARTAGO' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 14
    );
END
GO

CREATE PROCEDURE InsertarCantonesAlajuela
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 15
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'ALAJUELA' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 15
    );
END
GO

CREATE PROCEDURE InsertarCantonesHeredia
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT Cantón, 16
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'HEREDIA' AND Cantón <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = 16
    );
END
GO

EXEC InsertarCantonesSanJose;
GO
EXEC InsertarCantonesLimon;
GO
EXEC InsertarCantonesDesconocido;
GO
EXEC InsertarCantonesPuntarenas;
GO
EXEC InsertarCantonesGuanacaste;
GO
EXEC InsertarCantonesCartago;
GO
EXEC InsertarCantonesAlajuela;
GO
EXEC InsertarCantonesHeredia
GO

SELECT * FROM dw_project_normalized.dbo.dimension_canton
GO
DROP PROCEDURE IF EXISTS InsertarCantonesSanJose, InsertarCantonesLimon, InsertarCantonesDesconocido,
InsertarCantonesPuntarenas, InsertarCantonesGuanacaste, InsertarCantonesCartago,
InsertarCantonesAlajuela, InsertarCantonesHeredia
GO
----------
ALTER TABLE dw_project_normalized.dbo.dimension_canton NOCHECK CONSTRAINT ALL
GO
DELETE FROM dw_project_normalized.dbo.dimension_canton
GO
ALTER TABLE dw_project_normalized.dbo.dimension_canton CHECK CONSTRAINT ALL
GO


ALTER TABLE dw_project_normalized.dbo.dimension_provincia NOCHECK CONSTRAINT ALL
GO
DELETE FROM dw_project_normalized.dbo.dimension_provincia
GO
ALTER TABLE dw_project_normalized.dbo.dimension_provincia CHECK CONSTRAINT ALL
GO
-------




--------------ahora distritos

CREATE OR ALTER PROCEDURE InsertarDistritos
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_distrito (nombre_distrito, id_canton)
    SELECT DISTINCT Distrito, dc.id_canton
    FROM dbo.[Estadisticas Policiales 2024] ep
    INNER JOIN dw_project_normalized.dbo.dimension_canton dc
        ON ep.Cantón = dc.nombre_canton  -- Relacionamos por nombre
    WHERE Distrito IS NOT NULL
        AND Distrito <> 'DESCONOCIDO'
        AND NOT EXISTS (
            SELECT 1 FROM dw_project_normalized.dbo.dimension_distrito dd
            WHERE dd.nombre_distrito = ep.Distrito AND dd.id_canton = dc.id_canton
        );
END
GO

CREATE OR ALTER PROCEDURE InsertarDistritoDesconocido
AS
BEGIN
    -- Verifica si ya existe antes de insertarlo
    IF NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_distrito
        WHERE nombre_distrito = 'DESCONOCIDO'
    )
    BEGIN
        INSERT INTO dw_project_normalized.dbo.dimension_distrito (nombre_distrito, id_canton)
        VALUES ('DESCONOCIDO', 190);  -- ID del cantón "DESCONOCIDO"
    END
END
GO

EXEC InsertarDistritos;
EXEC InsertarDistritoDesconocido;

