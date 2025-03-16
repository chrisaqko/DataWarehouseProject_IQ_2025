---ETL
use master;

create database dump_dw_project
GO


use dump_dw_project
go



-- Situación socioeconómica por edad
CREATE TABLE situacion_socioeconomica_edad (
    Condicion_Pobreza VARCHAR(255),
    Edad INT,
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Situación socioeconómica por sexo
CREATE TABLE situacion_socioeconomica_sexo (
    Condicion_Pobreza VARCHAR(255),
    Sexo VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT
);

-- Deciles de ingreso
CREATE TABLE deciles_ingreso (
    Condicion_Pobreza VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Hogares INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Empleo por sexo
CREATE TABLE empleo_sexo (
    Condicion_Actividad VARCHAR(255),
    Sexo VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Empleo por edad
CREATE TABLE empleo_edad (
    Condicion_Actividad VARCHAR(255),
    Edad INT,
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Educación por sexo
CREATE TABLE educacion_sexo (
    Educacion VARCHAR(255),
    Sexo VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Educación por edad
CREATE TABLE educacion_edad (
    Educacion VARCHAR(255),
    Edad INT,
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Situación de vivienda y socioeconómica
CREATE TABLE vivienda_socioeconomica (
    Estado_FIS_Vivienda VARCHAR(255),
    Condicion_Pobreza VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Viviendas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Situación de vivienda y deciles de ingreso
CREATE TABLE vivienda_deciles_ingreso (
    Estado_FIS_Vivienda VARCHAR(255),
    Condicion_Actividad VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Viviendas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Situación de vivienda y empleo
CREATE TABLE vivienda_empleo (
    Estado_FIS_Vivienda VARCHAR(255),
    Condicion_Actividad VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Viviendas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Situación de vivienda y educación
CREATE TABLE vivienda_educacion (
    Estado_FIS_Vivienda VARCHAR(255),
    Educacion VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Viviendas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Inversión social de instituciones
CREATE TABLE inversion_social_instituciones (
    Institucion VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Programas sociales
CREATE TABLE programas_sociales (
    Programa VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por sexo
CREATE TABLE beneficios_sexos (
    Año INT,
    Beneficio VARCHAR(255),
    Sexo VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por edad
CREATE TABLE beneficios_edad (
    Año INT,
    Beneficio VARCHAR(255),
    Edad INT,
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por situación socioeconómica
CREATE TABLE beneficios_socioeconomicos (
    Año INT,
    Beneficio VARCHAR(255),
    Edad INT,
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por deciles de ingreso
CREATE TABLE beneficios_deciles_ingreso (
    Año INT,
    Beneficio VARCHAR(255),
    Decil_Pobreza VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por empleo
CREATE TABLE beneficios_empleo (
    Año INT,
    Beneficio VARCHAR(255),
    Decil_Pobreza VARCHAR(50),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por situación de vivienda
CREATE TABLE beneficios_vivienda (
    Año INT,
    Estado_FIS_Vivienda VARCHAR(255),
    Educacion VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Beneficios sociales por educación
CREATE TABLE beneficios_educacion (
    Año INT,
    Beneficio VARCHAR(255),
    Educacion VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255),
    Numero_Personas INT,
    Monto INT,
    Fecha_Consulta DATE,
    Fecha_Actualizacion DATE
);

-- Estadísticas policiales
CREATE TABLE estadisticas_policiales (
    Delito VARCHAR(255),
    SubDelito VARCHAR(255),
    Fecha DATE,
    Hora VARCHAR(50),
    Victima VARCHAR(255),
    SubVictima VARCHAR(255),
    Edad VARCHAR(50),
    Genero VARCHAR(50),
    Nacionalidad VARCHAR(255),
    Provincia VARCHAR(255),
    Canton VARCHAR(255),
    Distrito VARCHAR(255)
);


create database project_normalization
go

use project_normalization
go

