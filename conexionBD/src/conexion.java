
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author david
 */
public class conexion {
    
    Connection conexion;
    PreparedStatement PS;
    Statement st;
    ResultSet rs;
    String DriverDB;
    private final static String driver ="com.mysql.jdbc.Driver";
   
    
    public boolean conectar(String ip, String port,String usuario,String pass, String db){
       try{
        //verificamos si se encuentra el driver
        Class.forName("com.mysql.jdbc.Driver");
        //conexion = DriverManager.getConnection("jdbc:mysql://localhost/parkingdb","root","toor");
        DriverDB = "jdbc:mysql://" + ip+":"+port +"/"+db; //o "jdbc:mysql://"+ip+":"+port;
        conexion = DriverManager.getConnection(DriverDB,usuario,pass);//cargamos el driver
        st = conexion.createStatement();////instancear al statement para poder usarlo y realizar consultas
        System.out.println("conexion exitosa");
        return true;
       }catch(SQLException e){
           return false;
       }catch(ClassNotFoundException e){
           return false;
       }
    }
    
    public void cerrarConexion() throws SQLException{
        conexion.close();
    }

    public void insertar() {
        try {
            //     String query2 = "insert into usuario (id_auto,tipo,nombre,apellido,dir_img) values (00001,'Estudiante', 'David', 'Mata Viejo','el/directorio/es.jpg')";
            st.executeUpdate("INSERT INTO usuario (id_auto,tipo,nombre,apellido,dir_img) VALUES ('00001','Estudiante','David','Mata Viejo','el/directorio/es.jpg' )");
//st.executeUpdate(query2); 
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
    
    public String insertarUsuario(String id_usuario, String tipo, String nombre, String apellido, String placa, String dir_img){
        String exito="true";
try{ 
String query = "insert into usuarios (id_usuario,tipo,nombre,apellido,id_placa, dir_img) values (?,?,?,?,?,?)";
PS = conexion.prepareStatement(query);
PS.setString(1, id_usuario);
PS.setString(2, tipo);
PS.setString(3, nombre);
PS.setString(4, apellido);
PS.setString(5, placa);
PS.setString(6, dir_img);

PS.executeUpdate();
return exito;
}catch(SQLException e){
    return e.toString();
}
    }
    public String insertarAuto(String placa, String modelo, String color, String dir_img){
        String exito;
        try{
        String query = "insert into automovil (id_placa,modelo,color,dir_img) values (?,?,?,?)";
PS = conexion.prepareStatement(query);
PS.setString(1, placa);
PS.setString(2, modelo);
PS.setString(3, color);
PS.setString(4, dir_img);

PS.executeUpdate();
return exito="true";
        }catch(SQLException e){
            return e.toString();
        }
    }
    public void insertarTablaRegistro(String placa, String num_control) throws SQLException{
        java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   //get current date time with Date()
	  // Date date = new Date();
	  // System.out.println(dateFormat.format(date));
        String query = "insert into registroentrada (id_usuario,id_placa,fecha_ingreso) values (?,?,?)";
        PS = conexion.prepareStatement(query);
        PS.setString(1, num_control);
        PS.setString(2, placa);
       // PS.setDate(3, date);
        PS.setTimestamp(3, date);
        PS.executeUpdate();
        
    }
    public String [] getUsuariosData(String placa) throws SQLException{
        String [] data = new String [5];
        //st = conexion.createStatement();
        String query = "select id_usuario,tipo,nombre,apellido,dir_img from usuarios where id_placa = '" + placa+"'";
        //String query = "select id_usuario,tipo,nombre,apellido,dir_img  from usuarios where id_placa = 'JDB3445';";
        rs = st.executeQuery(query);
        while(rs.next()){
            data[0]= rs.getString("id_usuario");
            data[1]= rs.getString("tipo");
            data[2]= rs.getString("nombre");
            data[3]= rs.getString("apellido");
            data[4]= rs.getString("dir_img");
            System.out.println(data[0]+"  "+ data[1] +"  "+ data[2]+"  "+data[3]+"  "+data[4]);
            
            //System.out.println(rs.getString("id_usuario")+"  "+ rs.getString("tipo") +"  "+ rs.getString("nombre")+"  "+rs.getString("apellido")+"  "+rs.getString("dir_img"));
        }
        return data;
    }
    public String [] getAutoData(String placa)throws SQLException{
        String [] data = new String[3];
        String query = "select modelo, color, dir_img from automovil where id_placa ='"+ placa+"'";
        rs = st.executeQuery(query);
                while(rs.next()){
            data[0]= rs.getString("modelo");
            data[1]= rs.getString("color");
            data[2]= rs.getString("dir_img");
            System.out.println(data[0]+"  "+ data[1] +"  "+ data[2]);
            
            }
        return data;
    }
    
    public String [][] getRegistroData(int numRegistros)throws SQLException{
        //contamos el numero de registros para crear un vector
        
            String [][] data = new String [numRegistros][6];
        
        String query = "select registroentrada.id_registroEntrada, usuarios.tipo, usuarios.id_usuario, usuarios.nombre,usuarios.apellido, registroentrada.fecha_ingreso from registroentrada,usuarios where registroentrada.id_usuario = usuarios.id_usuario ORDER BY id_registroEntrada DESC LIMIT " + numRegistros;
        rs = st.executeQuery(query);

        int i = 0;
        while(rs.next() && numRegistros>i){
            //System.out.println(rs.getString(1)+" " +rs.getString(2)+"  "+rs.getString(3)+"  "+rs.getString(4)+  " " +rs.getString(5)+ "  "+ rs.getString(6));
            for(int j=0; j<6; j++){
                data[i][j] = rs.getString(j+1);
                System.out.println(data[i][j]);
            }
            i++;
        }
        return data;
    }
    public String[][] getRegistroData()throws SQLException{
        //contamos el numero de registros para crear un vector
        String query_count = "select count(*) from registroentrada";
        rs = st.executeQuery(query_count);
        rs.next();
            int numRegistros = Integer.parseInt(rs.getString(1));
            String [][] data = new String [numRegistros][6];
        
        String query = "select registroentrada.id_registroEntrada, usuarios.tipo, usuarios.id_usuario, usuarios.nombre,usuarios.apellido, registroentrada.fecha_ingreso from registroentrada,usuarios where registroentrada.id_usuario =usuarios.id_usuario";
        rs = st.executeQuery(query);

        int i = 0;
        while(rs.next() && numRegistros>i){
            //System.out.println(rs.getString(1)+" " +rs.getString(2)+"  "+rs.getString(3)+"  "+rs.getString(4)+  " " +rs.getString(5)+ "  "+ rs.getString(6));
            for(int j=0; j<6; j++){
                data[i][j] = rs.getString(j+1);
                System.out.println(data[i][j]);
            }
            i++;
        }
        return data;
    }
            
            public void getDataFromTabObjRes(String tabla, String obj, String restriccion) throws SQLException{
        String query = "select * from " + tabla + " where "+ obj + " = '" + restriccion+"'";
        System.out.println(query);
        st = conexion.createStatement();
        rs = st.executeQuery(query);
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnsNumber = rsmd.getColumnCount();
        System.out.println("el numero de columnas : " +columnsNumber);
        while(rs.next()){
        for(int i= 1; i<=columnsNumber; i++){
            System.out.println(rs.getObject(i));
        }
        }
       //     System.out.println(rs.getString("id_usuario")+"  "+ rs.getString("tipo") +"  "+ rs.getString("nombre")+"  "+rs.getString("apellido")+"  "+rs.getString("dir_img"));   
    }
  
    /*
    
    */
    
    public void escribirDir() throws SQLException{
        JFileChooser chooser = new JFileChooser();
chooser.setCurrentDirectory(new java.io.File("."));
//Titulo que llevara la ventana
chooser.setDialogTitle("Busqueda implacable");
//Elegiremos archivos del directorio
//chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
FileNameExtensionFilter filter = new FileNameExtensionFilter("JPG & GIF Images", "jpg", "gif");
chooser.setFileFilter(filter);
//chooser.setAcceptAllFileFilterUsed(false);
//Si seleccionamos algún archivo retornaremos su directorio
if (chooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
//System.out.println("Directorio: " + chooser.getCurrentDirectory());
//System.out.println("Nombre: " + chooser.getSelectedFile().getName());
//System.out.println("AbsolutePath: " + chooser.getSelectedFile().getAbsolutePath());
//System.out.println("getpath: " + chooser.getSelectedFile().getPath());
//System.out.println("toString: " + chooser.getSelectedFile().toString());
//String ext = ((FileNameExtensionFilter)chooser.getFileFilter()).getExtensions()[0];
//System.out.println("Extencion" + ext);
//String ext2 = ((FileNameExtensionFilter)chooser.getFileFilter()).getExtensions()[1];
//System.out.println("Extencion2" + ext2);
String query = "insert into image (img_pat) values (?)";
PS = conexion.prepareStatement(query);
PS.setString(1, chooser.getSelectedFile().getPath());
PS.executeUpdate();

} else {
System.out.println("No seleccion ");
}
    }
    public void imprimirRes() throws SQLException{
        while(rs.next()){
            System.out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3)+ " " + rs.getString(4)+ " " +rs.getString(5)+ " " + rs.getString(6));
        }
    }
    
        
    /*Para realizar cualquier acción sobre la base de datos (consulta, insertar nuevos registros, 
    modificar los existentes o borrar), necesitamos una clase Statement.*/
    public void consultar() throws SQLException{
        st = conexion.createStatement(); //La parte de createStatement() no tiene ningú secreto, salvo que puede lanzar una excepción que hay que capturar.
       //El Statement obtenido tiene un método executeQuery(). Este método sirve para realizar una consulta a base de datos.
        rs = st.executeQuery("select * from usuarios;");
        
        JFileChooser chooser = new JFileChooser();
chooser.setCurrentDirectory(new java.io.File("."));
//Titulo que llevara la ventana
chooser.setDialogTitle("Busqueda implacable");
//Elegiremos archivos del directorio
//chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
chooser.setAcceptAllFileFilterUsed(false);
//Si seleccionamos algún archivo retornaremos su directorio
if (chooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
System.out.println("Directorio: " + chooser.getCurrentDirectory());
String query = "insert into usuario (id_auto,tipo,nombre,apellido,dir_img) values (00001,'Estudiante', 'David', 'Mata Viejo', 'C:/Users/david/Pictures/Camera Roll/daniel.jpg')";
st.executeQuery(query);
String query2 = "insert into usuario (id_auto,tipo,nombre,apellido,dir_img) values (00001,'Estudiante', 'David', 'Mata Viejo','" + chooser.getCurrentDirectory() + "')";
st.executeQuery(query2);
//Si no seleccionamos nada retornaremos No seleccion
} else {
System.out.println("No seleccion ");
}
        
    }
    
    
    
}
