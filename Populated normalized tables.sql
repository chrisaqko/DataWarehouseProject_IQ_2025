--Inserts a las tablas de dimension

INSERT INTO dw_project_normalized.dbo.dimension_sexo (sexo) VALUES
('Masculino'),
('Femenino'),
('Otro'),
('No especificado');


INSERT INTO dw_project_normalized.dbo.dimension_edad (edad)
VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
(41), (42), (43), (44), (45), (46), (47), (48), (49), (50),
(51), (52), (53), (54), (55), (56), (57), (58), (59), (60),
(61), (62), (63), (64), (65), (66), (67), (68), (69), (70),
(71), (72), (73), (74), (75), (76), (77), (78), (79), (80),
(81), (82), (83), (84), (85), (86), (87), (88), (89), (90),
(91), (92), (93), (94), (95), (96), (97), (98), (99), (100),
(101), (102), (103), (104), (105), (106), (107), (108), (109), (110),
(111), (112), (113), (114), (115), (116), (117), (118), (119), (120);

INSERT INTO dw_project_normalized.dbo.dimension_sexo (sexo) VALUES
('Hombre'),
('Mujer');

--tomado de SSx
INSERT INTO dw_project_normalized.dbo.dimension_condicion_pobreza (condicion_pobreza) VALUES ('No Pobre');
INSERT INTO dw_project_normalized.dbo.dimension_condicion_pobreza (condicion_pobreza) VALUES ('Pobreza Básica');
INSERT INTO dw_project_normalized.dbo.dimension_condicion_pobreza (condicion_pobreza) VALUES ('Pobreza Extrema');
INSERT INTO dw_project_normalized.dbo.dimension_condicion_pobreza (condicion_pobreza) VALUES ('Vulnerable');
INSERT INTO dw_project_normalized.dbo.dimension_condicion_pobreza (condicion_pobreza) VALUES ('Por investigar');


--tomado de ambos datasets de educacion
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA OCTAVO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PREESCOLAR/PREPARATORIA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA CUARTO GRADO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA SÉTIMO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA PRIMER AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('UNIVERSITARIA BACHILLERATO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA DESCONOCIDA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA UNDÉCIMO AÑO / COMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('ENSEÑANZA ESPECIAL');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('UNIVERSITARIA INCOMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA INCOMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA SEGUNDO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA INCOMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA CUARTO AÑO / COMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA DUODÉCIMO AÑO / COMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA NOVENO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('UNIVERSITARIA LICENCIATURA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA INCOMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('NINGUNA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA QUINTO GRADO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA DESCONOCIDA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA DÉCIMO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA DESCONOCIDA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA SÉTIMO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA NOVENO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA OCTAVO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA INCOMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('UNIVERSITARIA DESCONOCIDA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA PRIMER GRADO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PARAUNIVERSITARIA TERCER AÑO / COMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA SEGUNDO GRADO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA DESCONOCIDA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('DESCONOCIDO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA SEXTO GRADO / COMPLETA');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('PRIMARIA TERCER GRADO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA TECNICA UNDÉCIMO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('SECUNDARIA ACADEMICA DÉCIMO AÑO');
INSERT INTO dw_project_normalized.dbo.dimension_educacion (educacion) VALUES ('UNIVERSITARIA POSTGRADO');


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

CREATE PROCEDURE InsertarCantonesSanJose
AS
BEGIN
    INSERT INTO dw_project_normalized.dbo.dimension_canton (nombre_canton, id_provincia)
    SELECT DISTINCT nombre_canton, id_provincia
    FROM dbo.[Estadisticas Policiales 2024]
    WHERE Provincia = 'SAN JOSÉ' AND  <> 'DESCONOCIDO'
    AND NOT EXISTS (
        SELECT 1 FROM dw_project_normalized.dbo.dimension_canton dc
        WHERE dc.nombre_canton = Cantón AND dc.id_provincia = id_provincia --que tiene en la base de datos normalizada
    );
END
GO


SELECT TOP (1000) [id_provincia]
      ,[nombre_provincia]
  FROM [dw_project_normalized].[dbo].[dimension_provincia]


SELECT TOP (1000) [id_canton]
      ,[nombre_canton]
      ,[id_provincia]
  FROM [dw_project_normalized].[dbo].[dimension_canton]


SELECT TOP (1000) [id_distrito]
      ,[nombre_distrito]
      ,[id_canton]
  FROM [dw_project_normalized].[dbo].[dimension_distrito]


SELECT TOP (1000) [id_sexo]
      ,[sexo]
  FROM [dw_project_normalized].[dbo].[dimension_sexo]

SELECT TOP (1000) [id_edad]
      ,[edad]
  FROM [dw_project_normalized].[dbo].[dimension_edad]

  SELECT TOP (1000) [id_educacion]
      ,[educacion]
  FROM [dw_project_normalized].[dbo].[dimension_educacion]

  SELECT TOP (1000) [id_condicion]
      ,[condicion_pobreza]
  FROM [dw_project_normalized].[dbo].[dimension_condicion_pobreza]

CREATE PROCEDURE MigrarDatos_SituacionSocioeconomica
AS
BEGIN
    SET NOCOUNT ON;




-- Inserción en la tabla de hechos normalizada
    INSERT INTO dw_project_normalized.dbo.hecho_situacion_socioeconomica_edad 
        (id_condicion_pobreza, id_edad, id_provincia, id_canton, id_distrito, numero_personas, fecha_consulta, fecha_actualizacion)
    SELECT 
        cp.condicion_pobreza, 
        ed.id_edad, 
        pr.id_provincia, 
        cn.id_canton, 
        dt.id_distrito,
        COUNT(*) AS numero_personas, -- Asumiendo que cada fila representa una persona
        GETDATE() AS fecha_consulta, -- Puedes cambiar esta lógica si tienes un campo de fecha en la tabla no normalizada
        GETDATE() AS fecha_actualizacion
    FROM dump_dw_project.dbo.SSxEdad tn  -- <<< Aquí se indica la BD de origen
    INNER JOIN dw_project_normalized.dbo.dimension_condicion_pobreza cp ON tn.[Estado Pobreza] = cp.condicion_pobreza
    INNER JOIN dw_project_normalized.dbo.dimension_edad ed ON tn.[Rango Edad] = ed.id_edad
    INNER JOIN dw_project_normalized.dbo.dimension_provincia pr ON tn.[Provincia] = pr.nombre_provincia
    INNER JOIN dw_project_normalized.dbo.dimension_canton cn ON tn.[Canton] = cn.nombre_canton
    INNER JOIN dw_project_normalized.dbo.dimension_distrito dt ON tn.[Distrito] = dt.nombre_distrito
    GROUP BY cp.condicion_pobreza, ed.id_edad, pr.id_provincia, cn.id_canton, dt.id_distrito;

    PRINT 'Migración completada exitosamente.';
END;
GO


EXEC MigrarDatos_SituacionSocioeconomica;


ALTER TABLE dw_project_normalized.dbo.hecho_beneficios_sexo 
ALTER COLUMN monto DECIMAL(18,2);

INSERT INTO dw_project_normalized.dbo.hecho_beneficios_sexo(numero_personas, monto)
SELECT 
    CAST([DistinctCountsnb003_id_persona] AS BIGINT), 
    CAST(REPLACE(Sumsnb204_monto, ',', '.') AS DECIMAL(18,2))
FROM [dump_dw_project].[dbo].[Beneficio-social-x-sexo_2023];

