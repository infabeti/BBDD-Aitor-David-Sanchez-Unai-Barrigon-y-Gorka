package bbdd;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

public class InsercionesActividades {
	
	private final SentenciasBBDD sentenciasBBDD = new SentenciasBBDD();
	private java.sql.Connection conexionConn;

	public InsercionesActividades(Conexion conexion) {
		this.conexionConn =  conexion.getConn();
	}

	
	public void insertarActividad(int transaccion, String fecha, double totalOperacion, String tipo, String nif) throws SQLException {
		try {
			PreparedStatement st = null;

			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.INSERTARACTIVIDAD);
			st.setInt(1, transaccion);
			st.setString(2, fecha);
			st.setDouble(3, totalOperacion);
			st.setString(4, tipo);
			st.setString(5, nif);
			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}		
	}
	
	public void ejecutarFuncion(int numTrans, String tipo) throws SQLException {
		try {   
			boolean comanda = false;
			if(tipo.equalsIgnoreCase("comanda"))
				comanda = true;
			
             CallableStatement cStmt = conexionConn.prepareCall(sentenciasBBDD.LLAMARFUNCION);    
             cStmt.setInt(1, numTrans);    
             cStmt.setBoolean(2, comanda);  
             ResultSet rs = cStmt.executeQuery(); 
            
             
             rs.next();
              Double output = rs.getDouble(1);
              
              PreparedStatement st = null;

  			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.ACTUALIZARTOTALOPERACION);
  			st.setDouble(1, output);
  			st.setInt(2, numTrans);

  			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
                   
        }catch (Exception e) {  
            e.printStackTrace();
        }
	}
	public void insertarPedido(int transaccion, String domicilio) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.INSERTARPEDIDO);
			try {
				st.setInt(1, transaccion);
				if (domicilio.equalsIgnoreCase("")) {
					st.setNull(2, Types.NULL);
				} else {
					st.setString(2, domicilio);
				}
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}
	public void insertarFactura(int transaccion, String nif) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.INSERTARFACTURA);
			st.setInt(1, transaccion);
			st.setString(2, nif);
			try {
				st.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (SQLException sqlException) {
			sqlException.printStackTrace();
		}
	}
	public boolean insertarComanda(int transaccion) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.INSERTARCOMANDA);
			try {
				st.setInt(1, transaccion);	
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
	public boolean insertarAprovisionamiento(int transaccion) {
		try {
			PreparedStatement st = null;
			st = (PreparedStatement) ((java.sql.Connection) conexionConn).prepareStatement(sentenciasBBDD.INSERTARAPROVISIONAMIENTO);
			try {
				st.setInt(1, transaccion);
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
}
