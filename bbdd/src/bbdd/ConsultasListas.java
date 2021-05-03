package bbdd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsultasListas {

	private java.sql.Connection conexionConn;
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();

	public ConsultasListas(Conexion conexion) {
		this.conexionConn = conexion.getConn();
	}

	public ResultSet cogerProductosLocal(String NIFLocal) {
		ResultSet rs = null;
		try {
			PreparedStatement st = null;

			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.CONSULTAPRODUCTOLOCAL);
			st.setString(1, NIFLocal);
			rs = st.executeQuery();

			
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return rs;
	}

	public ResultSet cogerProductosAprovisionamiento() {
		ResultSet rs = null;
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.ALIMENTOORDENADO);
			rs = st.executeQuery();
			
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet cogerListaPlatos(String NIFLocal) {
		ResultSet rs = null;
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.PLATOJOINCARTA);
			st.setString(1, NIFLocal);
			rs = st.executeQuery();
			
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return rs;
	}

}
