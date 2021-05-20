package bbdd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EjecutarAccion {

	public ResultSet consultar(PreparedStatement ps) {

		ResultSet resultSet = null;
		try {
			resultSet = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resultSet;
	}

	public void insertar(PreparedStatement ps) throws SQLException {
		try {
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ps.close();
	}
}
