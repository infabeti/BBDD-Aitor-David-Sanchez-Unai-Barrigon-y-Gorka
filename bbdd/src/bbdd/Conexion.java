package bbdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

	// constructor de la clase
	private final String NOMBREBD = "retoGrupo1";
	private final String USUARIO = "root";
	private final String PASSWORD = "elorrieta";
	private final String URLPUERTO33060 = "jdbc:mysql://localhost:33060/" + NOMBREBD + "?useUnicode=true&use"
			+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";

	private final String URLPUERTO3306 = "jdbc:mysql://localhost:3306/" + NOMBREBD + "?useUnicode=true&use"
			+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";

	private Connection conn = null;

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	// constructor de la clase
	public Conexion() {
		try {
			// obtener el driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// obtener la conexion
			conn = DriverManager.getConnection(URLPUERTO33060, USUARIO, PASSWORD);

			if (conn == null) {
				conn = DriverManager.getConnection(URLPUERTO3306, USUARIO, PASSWORD);
			}
			if (conn == null) {
				System.out.println("******************NO SE PUDO CONECTAR " + NOMBREBD);
				System.exit(0);
			} else {
				System.out.println(
						"Conectado correctamente a la base de datos " + NOMBREBD + " con el usuario " + USUARIO);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("ocurre una ClassNotFoundException : " + e.getMessage());
			System.exit(0);
		} catch (SQLException e) {
			System.out.println("ocurre una SQLException: " + e.getMessage());
			System.out.println("Verifique que Mysql esta encendido...");
			System.exit(0);
		}
	}
}
