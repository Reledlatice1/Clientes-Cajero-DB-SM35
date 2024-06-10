<?php
include './connection/conexion.php';

//$id_cliente = $_GET['id_cliente'];
$id_correspondencia = $_GET['id_correspondencia'];
$query = "call tb_clientes.sp_eliminar_correspondencia($id_correspondencia)";


$delete = $conexion->query($query);

header('Location: ./index.php');

?>