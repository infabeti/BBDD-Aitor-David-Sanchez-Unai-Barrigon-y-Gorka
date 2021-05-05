package bbdd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EjecutarAccion {

	private java.sql.Connection connection;

	public EjecutarAccion(Conexion conexion) throws SQLException {
		connection = conexion.getConn();
	}

	public ResultSet consultar(PreparedStatement ps) {

		ResultSet resultSet = null;
		try {
			resultSet = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resultSet;
	}

	public void insertar(PreparedStatement ps) {
		try {
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
