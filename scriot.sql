CREATE DATABASE tb_clientes;

USE tb_clientes;

CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    ap_paterno VARCHAR(50),
    ap_materno VARCHAR(50),
    fecha_nacimiento DATE,
    correo_electronico VARCHAR(100),
    telefono VARCHAR(10)
);

CREATE TABLE correspondencia(
    id_correspondencia INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    dirreccion VARCHAR(500),
    codigo_postal VARCHAR(5),
    referencia VARCHAR(50)
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
)

/*Creacion de indices de busqueda*/
CREATE INDEX idx_correo_electronico ON clientes(correo_electronico);
CREATE INDEX idx_telefono ON clientes(telefono);

CREATE INDEX idx_id_cliente ON correspondencia(id_cliente);

/*Procedimiento alamcenado*/
DELIMITER//
CREATE PROCEDURE insertar_cliente(
    IN nombre VARCHAR(50),
    IN ap_paterno VARCHAR(50),
    IN ap_materno VARCHAR(50),
    IN fecha_nacimiento DATE,
    IN correo_electronico VARCHAR(100),
    IN telefono VARCHAR(10)
) BEGIN
INSERT INTO clientes(
    nombre,
    ap_paterno,
    ap_materno,
    fecha_nacimiento,
    correo_electronico,
    telefono,
)VALUE (
    nombre,
    ap_paterno,
    ap_materno,
    fecha_nacimiento,
    correo_electronico,
    telefono
);
END//