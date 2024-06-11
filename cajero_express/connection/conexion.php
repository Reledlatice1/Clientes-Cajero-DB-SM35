<?php 

$hostname = "localhost";
$username = "root";
$password = "";
$database = "cajero";

$conexion = new mysqli($hostname, $username, $password, $database);
if($conexion->connect_error){
    die("la conexcion a fallado: " . $conexion->connect_error);
}

?>