<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo Prestamo</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="container">
            <h1>Nuevo Prestamo</h1>
            <button id="loadEjemplares" class="btn btn-primary">Cargar Ejemplares Disponibles</button>
            <br><br>
            <form action="PrestarServlet" method="post">
                <div class="mb-3">
                    <label for="idEjemplar" class="form-label">Selecciona un Ejemplar</label>
                    <select id="idEjemplar" name="idEjemplar" class="form-select" required>
                        <option value="">Seleccionar...</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Prestar</button>
            </form>
        </div>

        <script>
            $(document).ready(function() {
                $('#loadEjemplares').click(function() {
                    $.ajax({
                        url: 'ObtenerEjemplaresServlet',
                        method: 'GET',
                        dataType: 'json',
                        success: function(ejemplares) {
                            try {
                                var selectEjemplares = $('#idEjemplar');
                                selectEjemplares.empty();
                                selectEjemplares.append('<option value="">Seleccionar...</option>');
                                ejemplares.forEach(function(ejemplar) {
                                    var option = '<option value="' + ejemplar.id + '">' + ejemplar.titulo + ' (Ubicación: ' + ejemplar.ubicacion + ')</option>';
                                    selectEjemplares.append(option);
                                });
                            } catch (e) {
                                console.error('Error processing JSON: ', e);
                                console.error('Response data: ', ejemplares);
                            }
                        },
                        error: function() {
                            alert('Error al cargar los ejemplares');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
