package bbdd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

	public ArrayList<String[]> cogerProductosAprovisionamiento() {
		ArrayList<String[]> listaProd = new ArrayList<String[]>();
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.ALIMENTOORDENADO);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("a.nombre");
				String pCompra = String.valueOf(rs.getDouble("a.PCompra"));
				String tipo = rs.getString("a.Tipo");
				String feCad = String.valueOf(rs.getDate("a.FeCad"));
				String[] producto = new String[] { nombre, feCad, tipo, pCompra };
				listaProd.add(producto);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProd;
	}

	public ArrayList<String[]> cogerListaPlatos(String NIFLocal) {
		ArrayList<String[]> listaProd = new ArrayList<String[]>();
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.PLATOJOINCARTA);
			st.setString(1, NIFLocal);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				String nombre = rs.getString("p.Nombre");
				String pvp = String.valueOf(rs.getDouble("p.pvp"));
				String[] producto = new String[] {nombre, pvp};
				listaProd.add(producto);
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
		return listaProd;
	}

}
