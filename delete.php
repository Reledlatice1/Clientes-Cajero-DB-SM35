<?php
include './connection/conexion.php';

$id_cliente = $_GET['id_cliente'];
$query = "call tb_clientes.sp_eliminar_cliente('$id_cliente')";

$delete = $conexion->query($query);

header('Location: ./index.php')

?>