<?php 
//print_r($_GET)

$id_cliente = $_GET['id_cliente'];
include './connection/conexion.php';

$query = "SELECT * FROM clientes WHERE id_cliente = '$id_cliente'";
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
                    <form action="update.php" method="post">
                    <input type="hidden" name="id_cliente" value="<?= $fila['id_cliente']; ?>">
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <input type="text" class="form-control" name="nombre" value="<?= $fila['nombre']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Apellido paterno</label>
                            <input type="text" class="form-control" name="ap_paterno" value="<?= $fila['ap_paterno']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Apellido Materno</label>
                            <input type="text" class="form-control" name="ap_materno" value="<?= $fila['ap_materno']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Fecha nacimiento</label>
                            <input type="date" class="form-control" name="fecha_nacimiento" value="<?= $fila['fecha_nacimiento']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Correo Electronico</label>
                            <input type="email" class="form-control" name="correo_electronico" value="<?= $fila['correo_electronico']; ?>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Telefono</label>
                            <input type="tel" class="form-control" name="telefono" value="<?= $fila['telefono']; ?>">
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
