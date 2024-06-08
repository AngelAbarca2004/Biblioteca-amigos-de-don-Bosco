package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Connection.DBConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PagarPrestamoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PagarPrestamoServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        int idPrestamo = Integer.parseInt(request.getParameter("idPrestamo"));
        double monto = Double.parseDouble(request.getParameter("monto"));
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            String query = "SELECT id FROM usuarios WHERE nombre = ?";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, username);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int idUsuario = rs.getInt("id");

                        try (CallableStatement cs = con.prepareCall("{CALL InsertarPago(?, ?, ?)}")) {
                            cs.setInt(1, idUsuario);
                            cs.setDouble(2, monto);
                            cs.setInt(3, idPrestamo);
                            cs.execute();
                        }
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error procesando el pago del préstamo", e);
        } finally {
            DBConnection.closeConnection(con);
        }

        response.sendRedirect("menu.jsp");
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
        return "Servlet para pagar un préstamo";
    }
}
