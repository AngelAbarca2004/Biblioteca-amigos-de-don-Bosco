<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagar Prestamo</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="container">
            <h1>Pagar Prestamo</h1>
            <button id="loadPrestamos" class="btn btn-primary">Cargar Préstamos Vigentes</button>
            <br><br>
            <form action="PagarPrestamoServlet" method="post">
                <div class="mb-3">
                    <label for="idPrestamo" class="form-label">Selecciona un Préstamo</label>
                    <select id="idPrestamo" name="idPrestamo" class="form-select" required>
                        <option value="">Seleccionar...</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="monto" class="form-label">Monto</label>
                    <input type="number" step="0.01" class="form-control" id="monto" name="monto" required>
                </div>
                <button type="submit" class="btn btn-primary">Pagar</button>
            </form>
        </div>

        <script>
            $(document).ready(function() {
                $('#loadPrestamos').click(function() {
                    $.ajax({
                        url: 'PrestamosServlet',
                        method: 'GET',
                        dataType: 'json',
                        headers: { 'Accept': 'application/json' },
                        success: function(prestamos) {
                            var selectPrestamos = $('#idPrestamo');
                            selectPrestamos.empty();
                            selectPrestamos.append('<option value="">Seleccionar...</option>');
                            prestamos.forEach(function(prestamo) {
                                var option = '<option value="' + prestamo.id + '">' + prestamo.id + ' - ' + prestamo.idEjemplar + '</option>';
                                selectPrestamos.append(option);
                            });
                        },
                        error: function() {
                            alert('Error al cargar los préstamos');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
