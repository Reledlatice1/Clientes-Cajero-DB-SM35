<?php
    //print_r($_POST);
    include './connection/conexion.php';
    $id_cliente = $_POST['id_cliente'];
    $dirreccion = $_POST['dirreccion'];
    $codigo_postal = $_POST['codigo_postal'];
    $referencia = $_POST['referencia'];

    $query = "INSERT INTO correspondencia (id_cliente, dirreccion, codigo_postal, referencia) VALUES ('$id_cliente','$dirreccion', '$codigo_postal', '$referencia')";
    $insert = $conexion ->query($query);

    header('Location: ./index.php');
    //print_r($_GET)
?>