BEGIN TRANSACTION;

-- Actualizar Provincia
UPDATE [dump_dw_project].[dbo].[EstadisticasPoliciales2024] 
SET Provincia = 'DESCONOCIDO' 
WHERE Provincia IS NULL;

-- Procedimiento para insertar provincias únicas
IF OBJECT_ID('InsertarProvinciasUnicas', 'P') IS NOT NULL
    DROP PROCEDURE InsertarProvinciasUnicas;
GO
CREATE PROCEDURE InsertarProvinciasUnicas
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dw_project_normalized].[dbo].[dimension_provincia] (nombre_provincia)
    SELECT DISTINCT Provincia
    FROM [dump_dw_project].[dbo].[EstadisticasPoliciales2024] AS ep
    WHERE NOT EXISTS (
        SELECT 1 
        FROM [dw_project_normalized].[dbo].[dimension_provincia] AS dp
        WHERE dp.nombre_provincia = ep.Provincia
    );
END;
GO
EXEC InsertarProvinciasUnicas;

-- Actualizar Cantón
UPDATE [dump_dw_project].[dbo].[EstadisticasPoliciales2024] 
SET Cantón = 'DESCONOCIDO' 
WHERE Cantón IS NULL;

-- Procedimiento para insertar cantones únicos
IF OBJECT_ID('InsertarCantonesUnicos', 'P') IS NOT NULL
    DROP PROCEDURE InsertarCantonesUnicos;
GO
CREATE PROCEDURE InsertarCantonesUnicos
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO [dw_project_normalized].[dbo].[dimension_canton] (nombre_canton, id_provincia)
    SELECT DISTINCT ep.Cantón, dp.id_provincia
    FROM [dump_dw_project].[dbo].[EstadisticasPoliciales2024] AS ep
    INNER JOIN [dw_project_normalized].[dbo].[dimension_provincia] AS dp
        ON ep.Provincia = dp.nombre_provincia
    WHERE ep.Cantón IS NOT NULL 
          AND LTRIM(RTRIM(ep.Cantón)) <> ''
          AND LTRIM(RTRIM(ep.Cantón)) <> 'DESCONOCIDO'
          AND NOT EXISTS (
              SELECT 1 
              FROM [dw_project_normalized].[dbo].[dimension_canton] AS dc
              WHERE dc.nombre_canton = ep.Cantón
                AND dc.id_provincia = dp.id_provincia
          );
END;
GO
EXEC InsertarCantonesUnicos;

-- Actualizar Distrito
UPDATE [dump_dw_project].[dbo].[EstadisticasPoliciales2024] 
SET Distrito = 'DESCONOCIDO' 
WHERE Distrito IS NULL;

-- Procedimiento para insertar distritos con cantones
IF OBJECT_ID('InsertarDistritosConCantones', 'P') IS NOT NULL
    DROP PROCEDURE InsertarDistritosConCantones;
GO
CREATE PROCEDURE InsertarDistritosConCantones
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_canton INT;
    DECLARE @Distrito NVARCHAR(255);
    DECLARE @Canton NVARCHAR(255);

    SELECT DISTINCT E.[Distrito], E.[Cantón]
    INTO #DistritosUnicos
    FROM [dump_dw_project].[dbo].[EstadisticasPoliciales2024] E;

    DECLARE distrito_cursor CURSOR FOR
    SELECT [Distrito], [Cantón] FROM #DistritosUnicos;

    OPEN distrito_cursor;

    FETCH NEXT FROM distrito_cursor INTO @Distrito, @Canton;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @id_canton = [id_canton]
        FROM [dw_project_normalized].[dbo].[dimension_canton]
        WHERE [nombre_canton] = @Canton;

        IF @id_canton IS NOT NULL
        BEGIN
            INSERT INTO [dw_project_normalized].[dbo].[dimension_distrito] ([nombre_distrito], [id_canton])
            VALUES (@Distrito, @id_canton);
        END

        FETCH NEXT FROM distrito_cursor INTO @Distrito, @Canton;
    END

    CLOSE distrito_cursor;
    DEALLOCATE distrito_cursor;

    DROP TABLE #DistritosUnicos;
END;
GO
EXEC InsertarDistritosConCantones;

CREATE PROCEDURE Populate_Dimension_Edad
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[dimension_edad] (edad)
    SELECT DISTINCT Edad
    FROM [dump_dw_project].[dbo].[EstadisticasPoliciales2024]
    WHERE Edad IS NOT NULL
      AND Edad NOT IN (SELECT edad FROM [dw_project_normalized].[dbo].[dimension_edad]);
END;
EXEC Populate_Dimension_Edad;

CREATE PROCEDURE Populate_Dimension_Condicion_Pobreza
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[dimension_condicion_pobreza] (condicion_pobreza)
    SELECT DISTINCT Estado_Pobreza
    FROM [dump_dw_project].[dbo].[Beneficios-S-x-SE_2023]
    WHERE Estado_Pobreza IS NOT NULL
      AND Estado_Pobreza NOT IN (SELECT condicion_pobreza FROM [dw_project_normalized].[dbo].[dimension_condicion_pobreza]);
END;
EXEC Populate_Dimension_Condicion_Pobreza;

CREATE PROCEDURE Populate_Dimension_Educacion
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[dimension_educacion] (educacion)
    SELECT DISTINCT Nivel_Educativo
    FROM [dump_dw_project].[dbo].[Beneficios-sociales-x-Educacion_2023]
    WHERE Nivel_Educativo IS NOT NULL
      AND Nivel_Educativo NOT IN (SELECT educacion FROM [dw_project_normalized].[dbo].[dimension_educacion]);
END;
EXEC Populate_Dimension_Educacion;

CREATE PROCEDURE Populate_Dimension_Sexo
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[dimension_sexo] (sexo)
    SELECT DISTINCT Sexo
    FROM [dump_dw_project].[dbo].[Beneficio-social-x-sexo_2023]
    WHERE Sexo IS NOT NULL
      AND Sexo NOT IN (SELECT sexo FROM [dw_project_normalized].[dbo].[dimension_sexo]);
END;
EXEC Populate_Dimension_Sexo;

use dw_project_normalized;
go

CREATE TABLE dimension_Beneficio (
    id_Beneficio INT IDENTITY(1,1) PRIMARY KEY,
    Beneficio VARCHAR(255) UNIQUE
);

CREATE PROCEDURE Populate_Dimension_Beneficio
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[dimension_Beneficio] (Beneficio)
    SELECT DISTINCT sbn203_nombre
    FROM [dump_dw_project].[dbo].[Beneficio-social-x-sexo_2023]
    WHERE sbn203_nombre IS NOT NULL
      AND sbn203_nombre NOT IN (SELECT Beneficio FROM [dw_project_normalized].[dbo].[dimension_Beneficio]);
END;
EXEC Populate_Dimension_Beneficio;

CREATE PROCEDURE InsertarHechoBeneficiosSexo
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dw_project_normalized].[dbo].[hecho_beneficios_sexo]
    (
        id_beneficio,
        id_sexo,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        monto,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        b.id_Beneficio,
        s.id_sexo,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona,
        src.Sumsnb204_monto,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[Beneficio-social-x-sexo_2023] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_Beneficio] b 
        ON src.sbn203_nombre = b.Beneficio
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_sexo] s 
        ON src.Sexo = s.sexo
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton
    WHERE src.IsGrandTotalRowTotal = 0;
END;
EXEC InsertarHechoBeneficiosSexo;

CREATE PROCEDURE InsertarHechoDecilesIngreso
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dw_project_normalized].[dbo].[hecho_deciles_ingreso]
    (
        id_condicion_pobreza,
        id_provincia,
        id_canton,
        id_distrito,
        numero_hogares,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        cp.id_condicion,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.Recuento_de_snb002_id_hogar,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[SSxDeciles_21-8-24] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_condicion_pobreza] cp 
        ON src.Estado_Pobreza = cp.condicion_pobreza
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton;
END;
EXEC InsertarHechoDecilesIngreso;

CREATE PROCEDURE InsertarHechoEducacionEdad
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dw_project_normalized].[dbo].[hecho_educacion_edad]
    (
        id_educacion,
        id_edad,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        e.id_educacion,
        ed.id_edad,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[Educacion-x-edad_26-8-24] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_educacion] e 
        ON src.Nivel_Educativo = e.educacion
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_edad] ed 
        ON src.Rango_Edad = ed.edad
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton
    WHERE src.IsGrandTotalRowTotal = 0;
END;
EXEC InsertarHechoEducacionEdad;

CREATE PROCEDURE InsertarHechoEducacionSexo
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dw_project_normalized].[dbo].[hecho_educacion_sexo]
    (
        id_educacion,
        id_sexo,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        e.id_educacion,
        s.id_sexo,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[Educacion-x-sexo_26-8-24] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_educacion] e 
        ON src.Nivel_Educativo = e.educacion
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_sexo] s 
        ON src.Sexo = s.sexo
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton
    WHERE src.IsGrandTotalRowTotal = 0;
END;
EXEC InsertarHechoEducacionSexo;

CREATE PROCEDURE InsertarHechoEmpleoEdad
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO [dw_project_normalized].[dbo].[hecho_empleo_edad]
    (
        id_condicion_actividad,
        id_edad,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        ca.id_condicion_actividad,
        ed.id_edad,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[Beneficios-sociales-x-empleo_2023] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_condicion_actividad] ca 
        ON src.Condición_de_Actividad = ca.condicion_actividad
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_edad] ed 
        ON src.sbn203_nombre = ed.edad  -- Asegurar que sbn203_nombre representa la edad
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton
    WHERE src.IsGrandTotalRowTotal = 0;
END;
Exec InsertarHechoEmpleoEdad;

CREATE PROCEDURE InsertarHechoEmpleoSexo
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[hecho_empleo_sexo]
    (
        id_condicion_actividad,  
        id_sexo,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        NULL AS id_condicion_actividad,  
        s.id_sexo,
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.Recuento_de_snb003_id_persona,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[SSxSexo_9-7-24] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_sexo] s 
        ON src.Sexo = s.sexo
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton;
END;
Exec InsertarHechoEmpleoSexo;

CREATE PROCEDURE InsertarEstadisticasPoliciales
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[hecho_estadisticas_policiales]
    (
        delito,
        subdelito,
        fecha,
        hora,
        victima,
        subvictima,
        edad,
        genero,
        nacionalidad,
        id_provincia,
        id_canton,
        id_distrito
    )
    SELECT 
        src.Delito,
        src.SubDelito,
        src.Fecha,
        src.Hora,
        src.Victima,
        src.SubVíctima,
        src.Edad,
        src.Sexo,  -- Asumiendo que "Sexo" corresponde a "genero"
        src.Nacionalidad,
        p.id_provincia,
        c.id_canton,
        d.id_distrito
    FROM [dump_dw_project].[dbo].[EstadisticasPoliciales2024] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Cantón = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton;
END;
Exec InsertarEstadisticasPoliciales;

CREATE PROCEDURE InsertarSituacionSocioeconomicaEdad
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[hecho_situacion_socioeconomica_edad]
    (
        id_condicion_pobreza,
        id_edad,  -- Este valor podría ser NULL o un valor predeterminado
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas,
        fecha_consulta,
        fecha_actualizacion
    )
    SELECT 
        cp.id_condicion, -- Relacionando el campo de condicion pobreza
        NULL AS id_edad, -- Este valor podría ser NULL o relacionado si es necesario
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona,
        GETDATE(),
        GETDATE()
    FROM [dump_dw_project].[dbo].[Beneficios-S-x-SE_2023] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_condicion_pobreza] cp
        ON src.Estado_Pobreza = cp.condicion_pobreza
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton;
END;
Exec InsertarSituacionSocioeconomicaEdad;

CREATE PROCEDURE InsertarSituacionSocioeconomicaSexo
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dw_project_normalized].[dbo].[hecho_situacion_socioeconomica_sexo]
    (
        id_condicion_pobreza,
        id_sexo,
        id_provincia,
        id_canton,
        id_distrito,
        numero_personas
    )
    SELECT 
        cp.id_condicion, -- Relacionando el campo de condicion pobreza
        s.id_sexo, -- Relacionando el campo de sexo
        p.id_provincia,
        c.id_canton,
        d.id_distrito,
        src.DistinctCountsnb003_id_persona
    FROM [dump_dw_project].[dbo].[Beneficio-social-x-sexo_2023] src
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_condicion_pobreza] cp
        ON src.sbn203_nombre = cp.condicion_pobreza
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_sexo] s
        ON src.Sexo = s.sexo
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_provincia] p 
        ON src.Provincia = p.nombre_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_canton] c 
        ON src.Canton = c.nombre_canton AND c.id_provincia = p.id_provincia
    LEFT JOIN [dw_project_normalized].[dbo].[dimension_distrito] d 
        ON src.Distrito = d.nombre_distrito AND d.id_canton = c.id_canton;
END;
Exec InsertarSituacionSocioeconomicaSexo;

COMMIT TRANSACTION;
