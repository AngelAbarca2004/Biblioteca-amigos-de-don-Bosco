/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Connection.DBConnection;
import clases.Ejemplar;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ObtenerEjemplaresServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ObtenerEjemplaresServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        List<Ejemplar> ejemplares = new ArrayList<>();
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            try (CallableStatement cs = con.prepareCall("{CALL ObtenerEjemplaresDisponibles()}")) {
                try (ResultSet rs = cs.executeQuery()) {
                    while (rs.next()) {
                        Ejemplar ejemplar = new Ejemplar();
                        ejemplar.setId(rs.getString("id"));
                        ejemplar.setTitulo(rs.getString("titulo"));
                        ejemplar.setIdAutor(rs.getInt("id_autor"));
                        ejemplar.setTipo(rs.getString("tipo"));
                        ejemplar.setUbicacion(rs.getString("ubicacion"));
                        ejemplar.setCantidad(rs.getInt("cantidad"));
                        ejemplar.setPrestados(rs.getInt("prestados"));
                        ejemplar.setImagenURL(rs.getString("imagenURL"));
                        ejemplares.add(ejemplar);
                    }
                    LOGGER.log(Level.INFO, "Ejemplares obtenidos: {0}", ejemplares.size());
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error obteniendo los ejemplares", e);
        } finally {
            DBConnection.closeConnection(con);
        }

        try (PrintWriter out = response.getWriter()) {
            Gson gson = new Gson();
            String ejemplaresJson = gson.toJson(ejemplares);
            LOGGER.log(Level.INFO, "JSON generado: {0}", ejemplaresJson);
            out.print(ejemplaresJson);
            out.flush();
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
        return "Servlet para obtener los ejemplares disponibles";
    }
}

