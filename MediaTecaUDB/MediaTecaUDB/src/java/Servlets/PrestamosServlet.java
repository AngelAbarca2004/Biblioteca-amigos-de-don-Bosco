/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Connection.DBConnection;
import clases.Prestamo;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PrestamosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PrestamosServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        LOGGER.log(Level.INFO, "Obteniendo préstamos para el usuario: {0}", username);

        List<Prestamo> prestamos = new ArrayList<>();
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            String query = "SELECT p.id, p.id_ejemplar, p.fecha_prestamo, p.fecha_devolucion, p.estado FROM prestamos p JOIN usuarios u ON p.id_usuario = u.id WHERE u.nombre = ? AND p.estado = 'vigente'";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, username);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Prestamo prestamo = new Prestamo();
                        prestamo.setId(rs.getInt("id"));
                        prestamo.setIdEjemplar(rs.getString("id_ejemplar"));
                        prestamo.setFechaPrestamo(rs.getDate("fecha_prestamo"));
                        prestamo.setFechaDevolucion(rs.getDate("fecha_devolucion"));
                        prestamo.setEstado(rs.getString("estado"));
                        prestamos.add(prestamo);
                    }
                    LOGGER.log(Level.INFO, "Préstamos obtenidos: {0}", prestamos.size());
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error obteniendo los préstamos", e);
        } finally {
            DBConnection.closeConnection(con);
        }

        String acceptHeader = request.getHeader("Accept");
        if (acceptHeader != null && acceptHeader.contains("application/json")) {
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                Gson gson = new Gson();
                String prestamosJson = gson.toJson(prestamos);
                out.print(prestamosJson);
                out.flush();
            }
        } else {
            request.setAttribute("prestamos", prestamos);
            request.getRequestDispatcher("prestamos.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para ver los préstamos vigentes";
    }
}
