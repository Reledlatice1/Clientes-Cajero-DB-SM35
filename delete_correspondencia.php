<?php
include './connection/conexion.php';

$id_correspondencia = $_GET['id_correspondencia'];
$query = "DELETE FROM correspondencia WHERE id_correspondencia = $id_correspondencia";


$delete = $conexion->query($query);
print_r($_GET);
//header('Location: ./index.php ');

?>