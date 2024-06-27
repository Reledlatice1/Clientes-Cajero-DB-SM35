DELIMITER //

CREATE TRIGGER tg_consulta_saldo
BEFORE UPDATE ON tb_tarjeta
FOR EACH ROW
BEGIN
    DECLARE v_saldo DECIMAL(20,2);

    -- Asumiendo que tienes un tipo de movimiento para consulta de saldo
    DECLARE consulta_id INT;

    -- Suponiendo que tienes una tabla tb_tipo_movimiento con el tipo 'consulta'
    SELECT id_tipo_movimiento INTO consulta_id
    FROM tb_tipo_movimiento
    WHERE tipo = 'consulta';

    SET v_saldo = OLD.saldo;

    -- Verificar si el monto es negativo (no debería serlo en una consulta)
    IF NEW.saldo < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Monto de consulta inválido';
    ELSE
        -- Realizar el registro del movimiento de consulta de saldo
        INSERT INTO movimientos (monto, id_tarjeta, id_tipo_movimiento)
        VALUE (NEW.saldo, OLD.id_tarjeta, consulta_id);
    END IF;
END //

DELIMITER ;
