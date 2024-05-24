<!doctype html>
<html lang="en">
    <head>
        <title>Title</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />

        <!--CSS-->
        <link rel="stylesheet" href="css/interfaz.css" />
        <link rel="stylesheet" href="css/Styles.css" />
    </head>

    <body>
        <main>
            <h1 class="text-center fw-bold">Mis Clientes</h1>
            <div class="container p-3">
                <div class="row g-2" style="background-color: rgba(233, 120, 245, 0.722);">
                    <div class="col-3 p-3">
                        <h4 class="fw-bolder">Formulario</h4>
                        <form action="./insert.php" method="post">
                            <div class="mb-3">
                                <label class="form-label">Nombre</label>
                                <input type="text" class="form-control" name="nombre">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Apellido paterno</label>
                                <input type="text" class="form-control" name="ap_paterno">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Apellido Materno</label>
                                <input type="text" class="form-control" name="ap_materno">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Fecha nacimiento</label>
                                <input type="date" class="form-control" name="fecha_nacimiento">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Correo Electronico</label>
                                <input type="email" class="form-control" name="correo_electronico">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Telefono</label>
                                <input type="tel" class="form-control" name="telefono">
                            </div>
                            <button type="submit" class="btn btn-primary">Añadir</button>
                        </form>
                    </div>
                    <div class="col-9 p-4">
                        <h4 class="fw-bolder">Tabla</h4>
                        <div class="py-3">
                              <input type="text" class="form-control" name="" placeholder="Buscar">
                        </div>
                      
                        <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                            <table class="table table-striped table-ligth">
                                <thead>
                                    <tr>
                                        <th>Nombre Completo</th>
                                        <th>Fecha de nacimiento</th>
                                        <th>Correo Electronico</th>
                                        <th>Telefono</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    include './connection/conexion.php';
                                    $query = "SELECT * FROM clientes";
                                    $resultado = $conexion -> query($query);

                                    if($resultado->num_rows > 0){
                                        while($fila = $resultado -> fetch_assoc()){
                                            echo "
                                    <tr>
                                        <td>{$fila['nombre']} {$fila['ap_paterno']} {$fila['ap_materno']}</td>
                                        <td>{$fila['fecha_nacimiento']}</td>
                                        <td>{$fila['correo_electronico']}</td>
                                        <td>{$fila['telefono']}</td>
                                        <td>
                                            <a href='edit.php?id_cliente={$fila['id_cliente']}' class='btn btn-success'>Editar</a>
                                            <a href='delete.php?id_cliente={$fila['id_cliente']}' class='btn btn-danger'>Eliminar</a>
                                        </td>
                                    </tr>";
                                        }
                                    };
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    </body>
</html>