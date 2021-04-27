package bbdd;

public class SentenciasBBDD {

	// CONSULTAS BBDD
		protected final String CONSULTALOGUEAR = "Select e.nombre, es.nombre, tipoNegocio, e.NIF from empleado e join establecimiento es on e.NIF = es.NIF where dni=? and contrasena=?";
		protected final String CONSULTANIF = "Select nif from empleado where NIF=?";
		protected final String CONSULATDNI = "Select dni from empleado where dni=?";
		protected final String CONSULTAACTIVIDAD = "select * from actividad;";
		protected final String CONSULTAALIMENTO = "select * from alimento ;";
		protected final String INSERTARACTIVIDAD = "insert into actividad " + "values(?,?,?,?,?);";
		protected final String INSERTAREMPLEADO = "insert into empleado " + "values(?, ?, ?, ?, ?)";
		protected final String INSERTARPRODUCTOACTIVIDAD = "insert into lineaproducto (codigoalimento,transaccion,cantidad,preciofinal)" + "values(?,?,?,?);";
		protected final String CONSULTAPRODUCTOLOCAL = "Select a.Nombre, a.PCompra, p.PVenta, a.Tipo, a.FeCad from alimento a join producto p on a.CodigoAlimento = p.CodigoAlimento join stock s on a.CodigoAlimento = s.CodigoAlimento where s.NIF=?";
		protected final String INSERTARPEDIDO = "insert into pedido " + "values(?, ?)";
		protected final String INSERTARFACTURA = "insert into factura " + "values(?,?);";
		protected final String INSERTARCOMPRADOR = "insert into comprador " + "values(?,?,?);";
		protected final String EXISTECOMPRADOR = "select * from comprador where NIF=?;";
		protected final String CONSEGUIRCANTIDADSTOCK = "select Cantidad from stock where CodigoAlimento = (select CodigoAlimento from alimento where nombre=?) and nif =?;";
		protected final String REPLACESTOCK = "replace into stock " + "values(?, ?, ?)";
		protected final String INSERTARCOMANDA = "insert into comanda " + "values(?)";
		protected final String CONSULTAPLATO = "select * from plato ;";
		protected final String ALIMENTOORDENADO = "Select a.Nombre, a.PCompra, a.Tipo, a.FeCad from alimento a order by a.CodigoAlimento asc";
		protected final String PLATOJOINCARTA = "Select p.Nombre, p.pvp from plato p join carta c on p.codigoplato = c.codigoplato where c.nif=?";
		protected final String INSERTARAPROVISIONAMIENTO = "insert into aprovisionamiento " + "values(?,0)";	
		protected final String CONSEGUIRNIFPORTRANS = "select nif from actividad where Transaccion = (select transaccion from lineaproducto where Transaccion =?)";
		protected final String CODIGOALIMENTO = "SELECT cantidad from stock where CodigoAlimento =? and nif=?";
		protected final String PRECIOALIMENTO = "SELECT pcompra from alimento where CodigoAlimento =?";
		protected final String ACTUALIZARSTOCK = "update stock set cantidad=? where nif=? and codigoalimento=?";
		protected final String COMPROBARSIESAPROVISIONAMIENTO = "select tipo from actividad where transaccion=?";
		protected final String CONSEGUIRPRECIOPRODUCTO = "select PCompra from alimento where nombre=?";
		protected final String CONSEGUIRLOCAL = "SELECT nif, nombre, tiponegocio FROM establecimiento";
		protected final String LLAMARFUNCION = "select importetransacion(?, ?)";

}

	