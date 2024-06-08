<%@page import="clases.Prestamo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Prestamo> prestamos = (List<Prestamo>) request.getAttribute("prestamos");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Préstamos Vigentes</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="container">
            <h1>Préstamos Vigentes</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>ID Ejemplar</th>
                        <th>Fecha Préstamo</th>
                        <th>Fecha Devolución</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (prestamos != null && !prestamos.isEmpty()) {
                            for (Prestamo prestamo : prestamos) {%>
                    <tr>
                        <td><%= prestamo.getId()%></td>
                        <td><%= prestamo.getIdEjemplar()%></td>
                        <td><%= prestamo.getFechaPrestamo()%></td>
                        <td><%= prestamo.getFechaDevolucion() != null ? prestamo.getFechaDevolucion() : "Pendiente"%></td>
                        <td><%= prestamo.getEstado()%></td>
                    </tr>
                    <%   }
                    } else { %>
                    <tr>
                        <td colspan="5" class="text-center">No hay préstamos vigentes</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
