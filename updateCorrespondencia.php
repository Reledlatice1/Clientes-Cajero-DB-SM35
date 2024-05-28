<?php
include './connection/conexion.php';

$id_cliente = $_POST['id_cliente'];
$dirreccion = $_POST['dirreccion'];
$codigo_postal = $_POST['codigo_postal'];
$referencia = $_POST['referencia'];
$id_correspondencia = $_POST['id_correspondencia'];


$query = "UPDATE correspondencia SET id_cliente = '$id_cliente', dirreccion = '$dirreccion', codigo_postal = '$codigo_postal', 
referencia = '$referencia' WHERE id_correspondencia = '$id_correspondencia'";

$update = $conexion -> query($query);

header('Location: ./index.php' );
?>