package bbdd;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp2.BasicDataSource;


public class Conexion {

	// constructor de la clase
	private BasicDataSource ds = null;
	private final String NOMBREBD = "retoGrupo1";
	private final String USUARIO = "root";
	private final String PASSWORD = "elorrieta";
	private final String URLPUERTO33060 = "jdbc:mysql://localhost:33060/" + NOMBREBD + "?useUnicode=true&use"
			+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";

	private final String URLPUERTO3306 = "jdbc:mysql://localhost:3306/" + NOMBREBD + "?useUnicode=true&use"
			+ "JDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&" + "serverTimezone=UTC";

	public Connection getConn() throws SQLException {
		return ds.getConnection();
	}

	// constructor de la clase
	public Conexion() {
		try {
			if (ds == null) {
				// obtener el driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				ds = new BasicDataSource();
				ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
				ds.setUsername(USUARIO);
				ds.setPassword(PASSWORD);
				ds.setUrl(URLPUERTO33060);
				ds.setMaxOpenPreparedStatements(10);
				// Definimos el tamano del pool de conexiones
				ds.setInitialSize(50);// 50 Conexiones iniciales
				ds.setMaxIdle(10);
				if (ds == null) {
					
					ds = new BasicDataSource();
					ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
					ds.setUsername(USUARIO); 
					ds.setPassword(PASSWORD);
					ds.setUrl(URLPUERTO3306);
					ds.setMaxOpenPreparedStatements(10);
					ds.setMinIdle(50);
					ds.setMaxIdle(100);
				}
				
			}

		} catch (ClassNotFoundException e) {
			System.out.println("ocurre una ClassNotFoundException : " + e.getMessage());
			System.exit(0);
		}
	}
}
