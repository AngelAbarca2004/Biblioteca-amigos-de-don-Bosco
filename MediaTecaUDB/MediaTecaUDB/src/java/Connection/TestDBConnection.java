/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestDBConnection {
 
    public static void main(String[] args) {
        try {
            // Obtener la conexión
            Connection con = DBConnection.getConnection();
            
            // Verificar la conexión ejecutando una simple consulta
            String query = "SELECT 1";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            // Verificar el resultado de la consulta
            if (rs.next()) {
                System.out.println("Conexión exitosa: " + rs.getInt(1));
            } else {
                System.out.println("Fallo en la conexión");
            }
            
            // Cerrar la conexión
            rs.close();
            ps.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }   
}
