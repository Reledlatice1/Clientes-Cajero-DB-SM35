// DELIMITER

CREATE TRIGGER tg_retiro
BEFORE UPDATE ON tb_tarjeta
FOR EACH ROW 
BEGIN 

    DECLARE v_saldo DECIMAL(20,2);
    DECLARE v_monto DECIMAL(20, 2);
    DECLARE consulta_id INT;

    --consulta
    SELECT id_tipo_movimiento INTO consulta_id 
    FROM tb_tipo_moviminento
    WHERE tipo = "consulta";

    SET v_saldo = OLD.saldo;
        --resta el saldo acutal con el viejo
        
                INSERT INTO moviminento(monto, id_tarjeta, id_tipo_movimiento)
                VALUE (v_monto, OLD.id_tarjeta, retiro_id);

                --actualizar saldo
END

DELIMITER;


