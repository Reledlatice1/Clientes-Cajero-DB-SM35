// DELIMITER

CREATE TRIGGER tg_retiro
BEFORE UPDATE ON tb_tarjeta
FOR EACH ROW 
BEGIN 

    DECLARE v_saldo DECIMAL(20,2);
    DECLARE v_monto DECIMAL(20, 2);
    DECLARE v_id_tarjeta INT;

    --consulta
    SELECT id_tipo_movimiento INTO retiro_id 
    FROM tb_tipo_moviminento
    WHERE tipo = "retiro";

    SET v_saldo = OLD.saldo;
    SET v_monto = NEW.saldo - OLD.saldo;

    IF v_monto < 0 THEN
        --resta el saldo acutal con el viejo
        SET v_monto = -v_monto;
            IF v_saldo >= v_monto THEN
                INSERT INTO moviminento(monto, id_tarjeta, id_tipo_movimiento)
                VALUE (v_monto, OLD.id_tarjeta, retiro_id);

                --actualizar saldo
                SET NEW.saldo = OLD.saldo - v_saldo;
                ELSE 
                
                --mensaje de error
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
            END IF;
    END IF;

END

DELIMITER;


DELIMITER //

CREATE TRIGGER tg_retiro
BEFORE UPDATE ON tb_tarjeta
FOR EACH ROW
BEGIN

    DECLARE v_saldo DECIMAL(20,2);
    DECLARE v_monto DECIMAL(20,2);
    DECLARE retiro_id INT;

    SELECT id_tipo_movimiento INTO retiro_id
    FROM tb_tipo_movimiento
    WHERE tipo = 'retiro';

    SET v_saldo = OLD.saldo;
    SET v_monto = NEW.saldo - OLD.saldo;

    IF v_monto < 0 THEN
        SET v_monto = -v_monto;
            IF v_saldo >= v_monto THEN
                INSERT INTO movimientos (monto,id_tarjeta,id_tipo_movimiento)
                VALUE (v_monto,OLD.id_tarjeta,retiro_id);

                SET NEW.saldo = OLD.saldo - v_monto;

                ELSE

                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
            END IF;
    END IF;
END //