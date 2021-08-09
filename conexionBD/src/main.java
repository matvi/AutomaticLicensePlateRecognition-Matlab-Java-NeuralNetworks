
import java.sql.SQLException;
import java.sql.Timestamp;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author david
 */
public class main {
        public static void main(String[] args) throws SQLException, ClassNotFoundException {

        // TODO code application logic here
            conexion c = new conexion();
           
           // Timestamp timestamp = new Timestamp(new Date().getTime());
            //c.verificarDriver();
            c.conectar("localhost","3306", "root", "toor","parkingdb");
             c.insertarTablaRegistro("DIVAD67", "09020643");
            //c.getRegistroData(3);
        //    String [] data = c.getUsuariosData("JDB3445");
       //     c.getAutoData("JDB3445");
          //  String [][] data = new String [6][8];
            //.out.println(data.);
//            for (String data1 : data) {
//                System.out.println(data1);
//            }
            //c.getDataFromTabObjRes("usuarios", "id_placa", "JDB3445");
            //c.getUsuariosData("JDB3445");
            //c.insertarUsuario("09020643", "Estudiante", "David", "Mata Viejo", "JDB3445", "C:/Users/david/Dropbox/proyecto LPR/snapshot jal/DSC_0621.jpg");
            //c.insertar();
            //c.consultar();
            //c.imprimirRes();
    }
    
}
