
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de sesión</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/357aae614a.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="container">
            <nav class="navbar bg-body-tertiary navegacion">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <img src="./assets/logo.png" alt="Logo" width="60px" class="d-inline-block">
                        AMIGOS DE DON BOSCO
                    </a>
                </div>
            </nav>

            <div class="inicio-sesion">
                <form action="LoginServlet" method="post">
                    <b>
                        <h3>INICIO DE SESIÓN</h3>
                    </b>
                    <i class="fa-regular fa-user" style="font-size: 100px"></i>
                    <p>Carnet</p>
                    <input type="text" name="username" class="textbox" required/>
                    <p>Contraseña</p>
                    <input type="password" name="password" class="textbox" required/>
                    <br>
                    <input type="submit" class="btn-envio" value="Iniciar sesión"/>

                    <% String error = request.getParameter("error"); %>
                    <% if (error != null) { %>
                    <div class="alert alert-danger mt-3">
                        <% if ("1".equals(error)) { %>
                        Usuario o contraseña incorrectos.
                        <% } else if ("2".equals(error)) { %>
                        Ocurrió un error durante el proceso de inicio de sesión. Por favor, intenta de nuevo.
                        <% } %>
                    </div>
                    <script>
                        // Elimina el parámetro de error de la URL después de cargar la página
                        if (window.history.replaceState) {
                            const url = new URL(window.location);
                            url.searchParams.delete('error');
                            window.history.replaceState({}, document.title, url.toString());
                        }
                    </script>
                    <% }%>
                </form>
            </div>
        </div>
    </body>
</html>
