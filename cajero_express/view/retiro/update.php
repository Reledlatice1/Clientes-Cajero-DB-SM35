<?php
session_start();

include "../../connection/conexion.php";

if (isset($_POST['monto']) && isset($_SESSION['id'])) {

    $monto = $_POST['monto'];
    $id_tarjeta = $_SESSION['id'];
    //$sql = "SELECT saldo FROM tb_tarjeta WHERE id_tarjeta = '$id_tarjeta'";
    $sql = "call cajero.sp_buscarSaldo('$id_tarjeta')";
    $result = $conexion->query($sql);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $saldo_actual = $row['saldo'];
        $result->free();
        $conexion->next_result();

        if ($saldo_actual >= $monto) {
            $saldo_nuevo = $saldo_actual - $monto;

            //$sql_update = "UPDATE tb_tarjeta SET saldo = '$saldo_nuevo' WHERE id_tarjeta = '$id_tarjeta'";
            $sql_update = "call cajero.sp_actualizarSaldo('$saldo_nuevo', '$id_tarjeta')";
            if ($conexion->query($sql_update) === true) {
                $_SESSION['saldo'] = $saldo_nuevo;
                header("Location: ../home/index.php");
            }else{
                header("Location: ../home/index.php");
            };
        }else{
            header("Location: ../home/index.php");
        }

    }else{
        header("Location: ../home/index.php");
    }
}else{
    header("Location: ../../index.html");
}
