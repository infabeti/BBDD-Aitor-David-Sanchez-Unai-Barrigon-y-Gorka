package bbdd;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Inserciones {

	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	private java.sql.Connection conexionConn;
	private InsercionesActividades insercionesActividades;
	private Consultas consultas;
	
	public Inserciones(Conexion conexion) {
		this.conexionConn =  conexion.getConn();
		this.insercionesActividades = new InsercionesActividades(conexion);
		this.consultas = new Consultas(conexion);
	}


	public void insertarProductoActividad(int transaccion, String codigoAlimento, int cantidad, double precioFinal, String nif) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.INSERTARPRODUCTOACTIVIDAD);
			st.setString(1, codigoAlimento);
			st.setInt(2, transaccion);
			st.setInt(3, cantidad);
			st.setDouble(4, precioFinal);
			try {
				st.executeUpdate();
				try {
					PreparedStatement st2 = null;
					st2 = (PreparedStatement) ((java.sql.Connection) conexionConn)
							.prepareStatement(sentenciasBBDD.COMPROBARSIESAPROVISIONAMIENTO);
					st2.setInt(1, transaccion);
					ResultSet rs = st2.executeQuery();
					rs.next();
					if (rs.getString("tipo").equalsIgnoreCase("aprovisionamiento")) {
						actualizarStockMenorQueCinco(codigoAlimento, nif);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (precioFinal != 0) {
					actualizarStockMenorQueCinco(codigoAlimento, nif);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}

	public void actualizarStockMenorQueCinco(String codigoAlimento, String nif) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.CODIGOALIMENTO);
			st.setString(1, codigoAlimento);
			st.setString(2, nif);
			String fecha = "";
			try {
				ResultSet rs = st.executeQuery();
				rs.next();
				int cantidad = rs.getInt("cantidad");
				if (cantidad < 5) {
					try {
						PreparedStatement st1 = null;
						st1 = (PreparedStatement) ((java.sql.Connection) conexionConn)
								.prepareStatement(sentenciasBBDD.PRECIOALIMENTO);
						st1.setString(1, codigoAlimento);
						ResultSet rs1 = st1.executeQuery();
						rs1.next();
						int transaccion = this.consultas.leerNumTransBBDD();
						double pcompra = rs1.getDouble("PCompra");
						insercionesActividades.insertarActividad(transaccion,fecha,
								pcompra * 50, "aprovisionamiento", nif);
						insercionesActividades.insertarAprovisionamiento(transaccion);
						insertarProductoActividad(transaccion, codigoAlimento, 50, pcompra, nif);
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}

	public void updateStock(String nif, String codigoAlimento, int cantidad) {

		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.ACTUALIZARSTOCK);
			st.setInt(1, (cantidad + 50));
			st.setString(2, nif);
			st.setString(3, codigoAlimento);

			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}

	public void insertarComprador(String nif, String nombre, String apellido) {
		try {
			PreparedStatement st = null;

			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.INSERTARCOMPRADOR);
			st.setString(1, nif);
			st.setString(2, nombre);
			st.setString(3, apellido);
			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}

	public boolean insertarRegistro(String dni, String Nombre, String Apellido, String contrasena, String nif) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement(sentenciasBBDD.INSERTAREMPLEADO);
			try {
				st.setString(1, dni);
				st.setString(2, Nombre);
				st.setString(3, Apellido);
				st.setString(4, contrasena);
				st.setString(5, nif);
				st.executeUpdate();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
			return false;
		}
	}

	public void insertarPlatoActividad(int transaccion, String codigoPlato, int cantidad) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn)
					.prepareStatement("insert into lineaplato (codigoplato,transaccion,cantidad)" + " values("
							+ codigoPlato + "," + transaccion + "," + cantidad + ");");
			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}
}