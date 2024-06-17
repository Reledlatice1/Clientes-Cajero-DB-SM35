CREATE DATABASE cajero;
USE cajero;

CREATE TABLE tb_clientes(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25),
    ap_paterno VARCHAR(25),
    ap_materno VARCHAR(25)
);

CREATE tb_log_clientes(
    id_log_cliente INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR(20),
    id_clientet INT,
    nombre_completo VARCHAR(250),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_log_tarjetas(
    id_log_tarjetas INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR(20),
    id_tarjeta INT,
    n_tarjeta VARCHAR(20),
    saldo DECIMAL(20, 2),
    id_cliente INT NOT NULL
)

CREATE TABLE tb_tarjeta(
    id_tarjeta INT PRIMARY KEY AUTO_INCREMENT,
    n_tarjeta VARCHAR(16),
    nip VARCHAR(4),
    saldo DECIMAL(20, 2),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente)
);

CREATE TABLE tb_tipo_movimiento(
    id_tipo_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    tipo_movimiento VARCHAR(20)
);

CREATE TABLE movimientos(
    id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    monto DECIMAL(7,2 ),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    id_tarjeta INT,
    id_tipo_movimiento INT,
    FOREIGN KEY (id_tarjeta) REFERENCES tb_tarjeta(id_tarjeta),
    FOREIGN KEY (id_tipo_movimiento) REFERENCES tb_tipo_movimiento(id_tipo_movimiento)
);

/*
<---formularios--->
DATE 1990-09-25 
TIME 10:05:25
DATETIME 1990-09-25 10:05:25 NOW() <- INSERTA LA FECHA Y HORA DEL SERVIDOR
YEAR 1990

<---datos automaticos--->
TIMESTAMP CURRENT_TIMESTAMP: HORA Y FECHA ACTUAL DE ACUERDO A LA ZONA HORARIA DEL REGISTRO
*/