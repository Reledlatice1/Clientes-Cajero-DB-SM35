--insert--
DELIMITER //
CREATE TRIGGER tb_log_clientes_insert
AFTER INSERT ON tb_clientes FOR EACH ROW 
BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('INSERT', NEW.id_cliente, CONCAT (
        NEW.nombre, '',  NEW.ap_paterno, '', NEW.ap_materno 
    )
); END//

--update--
DELIMITER //
CREATE TRIGGER tb_log_clientes_update
AFTER UPDATE ON tb_clientes FOR EACH ROW 
BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('UPDATE', OLD.id_cliente, CONCAT (
            'viejo: ', OLD.nombre,' nuevo: ',NEW.nombre,
            ' ',
            'viejo: ', OLD.ap_paterno,' nuevo: ', NEW.ap_paterno,
            ' ',
            'viejo: ', OLD.ap_materno,' nuevo: ', NEW.ap_materno
        )
    ); END//

    

--delete--
DELIMITER //
    CREATE TRIGGER tb_log_clientes_delete
BEFORE DELETE ON tb_clientes
FOR EACH ROW 
BEGIN 
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES ('DELETE', OLD.id_cliente, CONCAT (
        OLD.nombre, '',  OLD.ap_paterno, '', OLD.ap_materno 
            ) 
        ); END//

--Trigger para el login--
 DELIMITER //
CREATE TRIGGER tb_login_clientes AFTER UPDATE ON tb_clientes
FOR EACH ROW
BEGIN
IF NEW.estado = 'Activo' AND OLD.estado <> 'Inactivo' THEN
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES('LOGIN', NEW.id_cliente, CONCAT(NEW.nombre, '', NEW.ap_paterno, '', NEW.ap_materno));
END IF;
    END//

    

     DELIMITER //
CREATE TRIGGER tb_logout_clientes AFTER UPDATE ON tb_clientes
FOR EACH ROW
BEGIN
IF NEW.estado = 'Inactivo' AND OLD.estado <> 'Activo' THEN
INSERT INTO tb_log_clientes (accion, id_cliente, nombre_completo)
VALUES('LOGOUT', OLD.id_cliente, CONCAT(OLD.nombre, '', OLD.ap_paterno, '', OLD.ap_materno));
END IF;
    END//