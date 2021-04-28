package bbdd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsultasComprobaciones {

	private java.sql.Connection conexionConn;
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();

	public ConsultasComprobaciones(Conexion conexion) {
		this.conexionConn =  conexion.getConn();
	}

	public boolean comprobarSiExisteNIF(String nif) {

		PreparedStatement st = null;
		try {
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULTANIF);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultaReal(st, nif);
	}

	public boolean comprobarSiExisteComprador(String nif) {
		PreparedStatement st = null;
		try {
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.EXISTECOMPRADOR);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultaReal(st, nif);
	}

	public boolean comprobarSiExisteDNI(String nif) {
		PreparedStatement st = null;
		try {
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSULATDNI);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultaReal(st, nif);
	}

	public boolean consultaReal(PreparedStatement st, String nif) {
		try {
			st.setString(1, nif);
			ResultSet rs = st.executeQuery();

			return rs.next();

		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return false;
	}
	
	public double consultaComprobarPrecio(String nombre) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.CONSEGUIRPRECIOPRODUCTO);
			st.setString(1, nombre);
			ResultSet rs = st.executeQuery();
			try {
				rs.next();
				return rs.getDouble("PCompra");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return 0.0;
	}
}
