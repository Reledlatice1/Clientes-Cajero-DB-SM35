<?php 
//print_r($_GET)

$id_correspondencia= $_GET['id_correspondencia'];
include './connection/conexion.php';

$query = "call tb_clientes.sp_correspondencia_por_id($id_correspondencia) ";
$resultado = $conexion -> query($query);

$fila = $resultado->fetch_assoc();



?>
<!doctype html>
<html lang="en">
    <head>
        <title>Title</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />

        <!-- Bootstrap CSS v5.2.1 -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
        />

        <link rel="stylesheet" href="css/edit.css"/>
    </head>

    <body>
        <header>
            <!-- place navbar here -->
        </header>
        <main>

        <h1 class="text-center fw-bold" >Editar Usuario</h1>

        <div class="container p-3">
                <div class="row justify-content-center g-2 form-container" style="background-color: #ffffff9a; " >
                <div class="col-4 p-3">
                    <h4 class="fw-bolder text-center">Formulario</h4>
                    <form action="updateCorrespondencia.php" method="post">
                    <input type="hidden" name="id_correspondencia" value="<?= $fila['id_correspondencia']; ?>">
                    <input type="hidden" name="id_cliente" value="<?= $fila['id_cliente']; ?>">
                        <div class="mb-3">
                            <label class="form-label">Direcion</label>
                            <input type="text" class="form-control" name="dirreccion" value="<?= $fila['dirreccion']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Codigo Postal</label>
                            <input type="text" class="form-control" name="codigo_postal" value="<?= $fila['codigo_postal']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Referencia</label>
                            <input type="text" class="form-control" name="referencia" value="<?= $fila['referencia']; ?>">
                        </div>

                    <button type="submit" class="btn btn-primary">Actualizar</button>
                </form>

                
                </div>
        </main>
        <footer>
            <!-- place footer here -->
        </footer>
        <!-- Bootstrap JavaScript Libraries -->
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"
        ></script>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"
        ></script>
    </body>
</html>