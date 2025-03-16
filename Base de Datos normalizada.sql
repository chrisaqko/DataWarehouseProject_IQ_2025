-- Crear la base de datos
CREATE DATABASE dw_project_normalized;
GO

USE dw_project_normalized;
GO

-- Dimensiones para Ubicación (Provincia, Cantón, Distrito)
CREATE TABLE dimension_provincia (
    id_provincia INT IDENTITY(1,1) PRIMARY KEY,
    nombre_provincia VARCHAR(255) UNIQUE
);

CREATE TABLE dimension_canton (
    id_canton INT IDENTITY(1,1) PRIMARY KEY,
    nombre_canton VARCHAR(255) UNIQUE,
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia)
);

CREATE TABLE dimension_distrito (
    id_distrito INT IDENTITY(1,1) PRIMARY KEY,
    nombre_distrito VARCHAR(255) UNIQUE,
    id_canton INT,
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton)
);

-- Dimensiones para Condición Socioeconómica, Sexo, Edad, y Educación
CREATE TABLE dimension_condicion_pobreza (
    id_condicion INT IDENTITY(1,1) PRIMARY KEY,
    condicion_pobreza VARCHAR(255) UNIQUE
);

CREATE TABLE dimension_sexo (
    id_sexo INT IDENTITY(1,1) PRIMARY KEY,
    sexo VARCHAR(50) UNIQUE
);

CREATE TABLE dimension_edad (
    id_edad INT IDENTITY(1,1) PRIMARY KEY,
    edad INT UNIQUE
);

CREATE TABLE dimension_educacion (
    id_educacion INT IDENTITY(1,1) PRIMARY KEY,
    educacion VARCHAR(255) UNIQUE
);

-- Hechos: Situación Socioeconómica por Edad
CREATE TABLE hecho_situacion_socioeconomica_edad (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_condicion_pobreza INT,
    id_edad INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_condicion_pobreza) REFERENCES dimension_condicion_pobreza(id_condicion),
    FOREIGN KEY (id_edad) REFERENCES dimension_edad(id_edad),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Situación Socioeconómica por Sexo
CREATE TABLE hecho_situacion_socioeconomica_sexo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_condicion_pobreza INT,
    id_sexo INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    FOREIGN KEY (id_condicion_pobreza) REFERENCES dimension_condicion_pobreza(id_condicion),
    FOREIGN KEY (id_sexo) REFERENCES dimension_sexo(id_sexo),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Deciles de Ingreso
CREATE TABLE hecho_deciles_ingreso (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_condicion_pobreza INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_hogares INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_condicion_pobreza) REFERENCES dimension_condicion_pobreza(id_condicion),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Empleo por Sexo
CREATE TABLE hecho_empleo_sexo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_condicion_actividad INT,
    id_sexo INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_condicion_actividad) REFERENCES dimension_condicion_pobreza(id_condicion), -- Se ajusta según tu fuente de datos
    FOREIGN KEY (id_sexo) REFERENCES dimension_sexo(id_sexo),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Empleo por Edad
CREATE TABLE hecho_empleo_edad (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_condicion_actividad INT,
    id_edad INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_condicion_actividad) REFERENCES dimension_condicion_pobreza(id_condicion), -- Se ajusta según tu fuente de datos
    FOREIGN KEY (id_edad) REFERENCES dimension_edad(id_edad),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Educación por Sexo
CREATE TABLE hecho_educacion_sexo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_educacion INT,
    id_sexo INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_educacion) REFERENCES dimension_educacion(id_educacion),
    FOREIGN KEY (id_sexo) REFERENCES dimension_sexo(id_sexo),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Educación por Edad
CREATE TABLE hecho_educacion_edad (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_educacion INT,
    id_edad INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_educacion) REFERENCES dimension_educacion(id_educacion),
    FOREIGN KEY (id_edad) REFERENCES dimension_edad(id_edad),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Beneficios Sociales por Sexo
CREATE TABLE hecho_beneficios_sexo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_beneficio INT,
    id_sexo INT,
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    numero_personas INT,
    monto INT,
    fecha_consulta DATE,
    fecha_actualizacion DATE,
    FOREIGN KEY (id_beneficio) REFERENCES dimension_condicion_pobreza(id_condicion), -- Se ajusta según tu fuente de datos
    FOREIGN KEY (id_sexo) REFERENCES dimension_sexo(id_sexo),
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);

-- Hechos: Estadísticas Policiales
CREATE TABLE hecho_estadisticas_policiales (
    id INT IDENTITY(1,1) PRIMARY KEY,
    delito VARCHAR(255),
    subdelito VARCHAR(255),
    fecha DATE,
    hora VARCHAR(50),
    victima VARCHAR(255),
    subvictima VARCHAR(255),
    edad VARCHAR(50),
    genero VARCHAR(50),
    nacionalidad VARCHAR(255),
    id_provincia INT,
    id_canton INT,
    id_distrito INT,
    FOREIGN KEY (id_provincia) REFERENCES dimension_provincia(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES dimension_canton(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES dimension_distrito(id_distrito)
);
