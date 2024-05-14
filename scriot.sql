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

