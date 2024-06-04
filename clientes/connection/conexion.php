<?php

$hostname = "localhost";
$username = "root";
$password = "";
$database = "tb_clientes";

$conexion = new mysqli($hostname, $username, $password, $database);
if($conexion->connect_error ){
    die("La conexion fallo: " . $conexion->connect_error);
}

?>