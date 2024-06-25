<?php 

session_start();

if(!isset($_SESSION['id'])){
    header("Location: ../../index.html");
}
?>

<!doctype html>
<html lang="en">

<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
</head>

<style>
    body {
        background-image: url('https://www.bbva.com/wp-content/uploads/2022/03/BBVA-fondos-cotizados.jpg');
        /*background-image: url('/img/fondo.jpg');*/
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        color: #fff;
        height: 100vh;

    }


    html,
    body {
        height: 100%;
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    main {
        flex: 1;
    }
</style>

<body>
    <header>
        <nav class="navbar navbar-expand-sm navbar-primary" style="background-color: rgb(5, 41, 98);">
            <div class="container">
                <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-bank" viewBox="0 0 16 16">
                    <path d="m8 0 6.61 3h.89a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5H15v7a.5.5 0 0 1 .485.38l.5 2a.498.498 0 0 1-.485.62H.5a.498.498 0 0 1-.485-.62l.5-2A.5.5 0 0 1 1 13V6H.5a.5.5 0 0 1-.5-.5v-2A.5.5 0 0 1 .5 3h.89zM3.777 3h8.447L8 1zM2 6v7h1V6zm2 0v7h2.5V6zm3.5 0v7h1V6zm2 0v7H12V6zM13 6v7h1V6zm2-1V4H1v1zm-.39 9H1.39l-.25 1h13.72z" />
                </svg>
                <a class="navbar-brand text-light" href="#">| Cajero Express | BBVA</a>
                <div class="collapse navbar-collapse" id="collapsibleNavId">
                    <ul class="navbar-nav me-auto mt-2 mt-lg-0">
                        <li class="nav-item">

                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <main>
        <h1 class="fw-bold text-center p-4">Retirar Dinero</h1>

        <form class="container vstack gap-3 col-md-5 mx-auto p-4 shadow"  action="update.php" method="post" style="background-color: rgba(0, 102, 255, 0.405);">
            <h3 class="text-center p-1" style="font-size: 50px;">$90000.00 MXM</h3>
            <h2 class="text-center">Saldo actual</h2>
            <div class="contenedor" style=" display: flex; justify-content: center; margin-top: 10px;">
                <button class="btn btn-success" style="margin-left: 10px">$50</button>
                <button class="btn btn-success" style="margin-left: 10px">$100</button>
                <button class="btn btn-success" style="margin-left: 10px">$200</button>
                <button class="btn btn-success" style="margin-left: 10px">$500</button>
            </div>

            <label class="form-label">Ingrese el monto a retirar</label>
            <input type="number" name="monto" class="form-control mb-4">
            <button class="btn btn-primary" type="submit">Retirar dinero</button>
            <a class="btn btn-danger p-2" href="../home/index.php">Cancelar Operacion</a>
        </form>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>

</html>