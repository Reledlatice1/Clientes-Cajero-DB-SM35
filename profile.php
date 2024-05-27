<?php 
$id_cliente = $_GET['id_cliente'];
include './connection/conexion.php';

$query = "call tb_clientes.sp_cliente_por_id($id_cliente)";
$resultado = $conexion -> query($query);

$fila = $resultado->fetch_assoc();


?>


<!doctype html>
<html lang="en">

<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
</head>

<body>
    <header>
        <!-- place navbar here -->
    </header>
    <main>

    <h1 class="text-center fw-bold">Perfil del cliente</h1>
    <div class="container py-5">
        <div class="row">
            <div class="col-4">
            <div class="p-3" style=" background-color: red; color: #fff; ">
            <div class="">
                <h3 class="card-title"> Perfil de: <?= $fila['nombre']?> <?=$fila['ap_paterno']?>
                    <?=$fila['ap_materno']?> </h3>
                <h5>Correo: <?= $fila['correo_electronico']?></h5>
                <h5>Telefono: <?= $fila['telefono']?></h5>
            </div>
        </div>
            </div>
            <div class="col-8 ">
                <table class="table table-striped table-ligth">
                    <thead>
                        <tr>
                            <th>Dirrecion</th>
                            <th>Codigo postal</th>
                            <th>Referencia</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                         include './connection/conexion.php';
                         $query2 = "SELECT*FROM correspondencia";
                         $resultado2 = $conexion -> query($query2);

                         if($resultado2->num_rows > 0){
                             while($fila2 = $resultado2 -> fetch_assoc()){
                                 echo "  <tr>
                                 <td>{$fila2['dirreccion']}</td>
                                 <td>{$fila2['codigo_postal']}</td>
                                 <td>{$fila2['referencia']}</td>
                                 <td>
                                     <a href='' class='btn btn-success'>Editar</a>
                                     <a href='delete_correspondencia.php?id_corespondencia={$fila2['id_correspondencia']}' class='btn btn-danger'>Eliminar</a>
                                 </td>
                                </tr>"; }
                                };
                        ?>
                      
                    </tbody>
                </table>
            </div>
            </div>
        </div>
    </div>
        


    </main>
    <footer>
        <!-- place footer here -->
    </footer>
    <!-- Bootstrap JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous">
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous">
    </script>
</body>

</html>