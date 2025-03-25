--- LLENADO DEL DATAMART - CONSULTAS A LA BASE DE DATOS NORMALIZADA

--- DIM.UBICACION
INSERT INTO dw_datamart.dbo.dim_ubicacion (provincia, canton, distrito)
SELECT DISTINCT p.nombre_provincia, c.nombre_canton, d.nombre_distrito
FROM dw_project_normalized.dbo.dimension_provincia p
JOIN dw_project_normalized.dbo.dimension_canton c ON p.id_provincia = c.id_provincia
JOIN dw_project_normalized.dbo.dimension_distrito d ON c.id_canton = d.id_canton
GO

--- DIM.SEXO
INSERT INTO dw_datamart.dbo.dim_sexo (sexo)
SELECT DISTINCT sexo
FROM dw_project_normalized.dbo.dimension_sexo
GO


--- DIM.EDAD 
INSERT INTO dw_datamart.dbo.dim_edad (edad)
SELECT DISTINCT edad
FROM dw_project_normalized.dbo.dimension_edad
GO

--- DIM.DELITO
INSERT INTO dw_datamart.dbo.dim_delito (delito, subdelito)
SELECT DISTINCT delito, subdelito
FROM dw_project_normalized.dbo.hecho_estadisticas_policiales
GO

--- DIM.TIEMPO
INSERT INTO dw_datamart.dbo.dim_tiempo (anio, mes, dia, fecha)
SELECT DISTINCT 
    YEAR(fecha) AS anio, 
    MONTH(fecha) AS mes, 
    DAY(fecha) AS dia, 
    fecha
FROM dw_project_normalized.dbo.hecho_estadisticas_policiales;

--- HECHOS_DELITOS
INSERT INTO dw_datamart.dbo.hechos_delitos (ubicacion_id, tiempo_id, sexo_id, edad_id, delito_id, numero_personas, monto)
SELECT 
    u.ubicacion_id,
    t.tiempo_id,
    s.sexo_id,
    e.edad_id,
    d.delito_id,
    COUNT(*) AS numero_personas,
    0 AS monto
FROM dw_project_normalized.dbo.hecho_estadisticas_policiales h
JOIN dw_datamart.dbo.dim_ubicacion u 
    ON h.id_provincia = u.ubicacion_id
    AND h.id_canton = u.ubicacion_id
    AND h.id_distrito = u.ubicacion_id
JOIN dw_datamart.dbo.dim_tiempo t ON h.fecha = t.fecha
JOIN dw_datamart.dbo.dim_sexo s ON h.genero = s.sexo
JOIN dw_datamart.dbo.dim_edad e ON h.edad = CAST(e.edad AS NVARCHAR)
JOIN dw_datamart.dbo.dim_delito d ON h.delito = d.delito AND h.subdelito = d.subdelito
GROUP BY u.ubicacion_id, t.tiempo_id, s.sexo_id, e.edad_id, d.delito_id
GO