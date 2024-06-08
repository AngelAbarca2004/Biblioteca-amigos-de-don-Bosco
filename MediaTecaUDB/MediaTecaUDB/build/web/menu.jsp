<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String tipoUsuario = (String) session.getAttribute("tipoUsuario");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <link rel="stylesheet" href="css/menu.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/357aae614a.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="container menu-container">
            <h1 class="text-center">Bienvenido, <%= session.getAttribute("username")%></h1>
            <div class="menu-options">
                <%-- Botones para todas las opciones, ajusta según el tipo de usuario --%>
                <button class="menu-btn" onclick="location.href = 'PrestamosServlet'">Prestamos</button>
                <button class="menu-btn" onclick="location.href = 'prestar.jsp'">Prestar</button>
                <button class="menu-btn" onclick="location.href = 'pagar.jsp'">Pagar</button>
                <button class="menu-btn" onclick="location.href = 'logout.jsp'">Cerrar Sesión</button>

                <%-- Ejemplo de opciones condicionales: --%>
                <% if ("Administrador".equals(tipoUsuario)) { %>
                <button class="menu-btn" onclick="location.href = 'admin.jsp'">Opciones de Administrador</button>
                <% } else if ("Profesor".equals(tipoUsuario)) { %>
                <button class="menu-btn" onclick="location.href = 'profesor.jsp'">Opciones de Profesor</button>
                <% } else if ("Alumno".equals(tipoUsuario)) { %>
                <button class="menu-btn" onclick="location.href = 'alumno.jsp'">Opciones de Alumno</button>
                <% }%>
            </div>
        </div>
    </body>
</html>
