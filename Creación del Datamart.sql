USE MASTER
GO

CREATE DATABASE dw_datamart
GO

USE dw_datamart
GO


CREATE TABLE dim_ubicacion (
    ubicacion_id INT PRIMARY KEY IDENTITY(1,1),
    provincia VARCHAR(255),
    canton VARCHAR(255),
    distrito VARCHAR(255)
);


CREATE TABLE dim_tiempo (
    tiempo_id INT PRIMARY KEY IDENTITY(1,1),
    anio INT,
    mes INT,
    dia INT,
    fecha DATE
);

CREATE TABLE dim_sexo (
    sexo_id INT PRIMARY KEY IDENTITY(1,1),
    sexo VARCHAR(50)
);

CREATE TABLE dim_edad (
    edad_id INT PRIMARY KEY IDENTITY(1,1),
    edad NVARCHAR(50)
);

CREATE TABLE dim_delito (
    delito_id INT PRIMARY KEY IDENTITY(1,1),
    delito VARCHAR(255),
    subdelito VARCHAR(255)
);

CREATE TABLE hechos_delitos (
    hecho_id INT PRIMARY KEY IDENTITY(1,1),
    ubicacion_id INT,
    tiempo_id INT,
    sexo_id INT,
    edad_id INT,
    delito_id INT,
    numero_personas INT,
    monto INT,  -- Solo para los casos de inversi�n social o beneficios
    FOREIGN KEY (ubicacion_id) REFERENCES dim_ubicacion(ubicacion_id),
    FOREIGN KEY (tiempo_id) REFERENCES dim_tiempo(tiempo_id),
    FOREIGN KEY (sexo_id) REFERENCES dim_sexo(sexo_id),
    FOREIGN KEY (edad_id) REFERENCES dim_edad(edad_id),
    FOREIGN KEY (delito_id) REFERENCES dim_delito(delito_id)
);
