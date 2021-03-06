
create database retoGrupo1 collate utf8mb4_spanish_ci;

use retoGrupo1;

/*Local cambiado por establecimiento porque local es una palabra reservada en SQL*/

create table establecimiento(
NIF char(9) primary key,
Nombre varchar(40) not null,
Direccion varchar(40) not null,
TipoNegocio enum ('BAR', 'CAFETERIA', 'RESTAURANTE') not null
);

create table actividad(
Transaccion int primary key,
Fecha date not null,
TotalOperacion float not null default 0, /* SE CALCULA MEDIANTE PROCEDIMIENTO */
tipo enum ('TICKET', 'FACTURA', 'COMANDA', 'PEDIDO', 'APROVISIONAMIENTO') not null,
NIF char(9) not null,
constraint fk_NIF_actividad foreign key (NIF) references establecimiento (NIF) on update cascade
);

create table alimento(
CodigoAlimento int primary key,
Nombre varchar(40) not null,
Tipo enum ('BEBIDA', 'COMIDA', 'OTROS')  not null,
FeCad date,
PCompra float not null default false,
vegetariano boolean not null  default false,
marisco boolean not null default false,
vegano boolean not null default false,
gluten boolean not null default false,
FrutosSecos boolean not null default false
);

create table stock(
NIF char(9) not null,
CodigoAlimento int not null,
cantidad int not null,
constraint pk_stock primary key (NIF, CodigoAlimento),
constraint fk_NIF_stock foreign key (NIF) references establecimiento (NIF) on update cascade,
constraint fk_NIF_CodigoAlimento foreign key (CodigoAlimento) references alimento (CodigoAlimento) on update cascade
);

create table producto(
CodigoAlimento int primary key,
PVenta float not null,
constraint fk_producto_codigoAlimento foreign key (CodigoAlimento) references alimento (CodigoAlimento) on update cascade
);

create table ingrediente(
CodigoAlimento int primary key,
constraint fk_ingrediente_codigoAlimento foreign key (CodigoAlimento) references alimento (CodigoAlimento) on update cascade
);

create table lineaproducto(
CodigoAlimento int,
Transaccion int,
Cantidad int not null,
PrecioFinal float not null,
TotalProducto float AS (Cantidad * PrecioFinal), /*Atributo calculado*/
constraint pk_lineaproducto primary key (Transaccion, CodigoAlimento),
constraint fk_lineaproducto_codigoAlimento foreign key (CodigoAlimento) references producto (CodigoAlimento) on update cascade,
constraint fk_lineaproducto_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table composicion(
CodigoAlimentoProducto int,
CodigoAlimentoIngrediente int,
cantidad int,
constraint pk_composicion primary key (CodigoAlimentoProducto, CodigoAlimentoIngrediente),
constraint fk_composicion_CodigoAlimentoProducto foreign key (CodigoAlimentoProducto) references producto (CodigoAlimento) on update cascade,
constraint fk_composicion_CodigoAlimentoIngredienteo foreign key (CodigoAlimentoIngrediente) references ingrediente (CodigoAlimento) on update cascade
);

create table comprador(
NIF char(9) primary key,
Nombre varchar(20) not null,
Apellido varchar(25) not null
);

create table factura(
Transaccion int primary key,
NIF char(9) not null,
constraint fk_factura_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade,
constraint fk_factura_nif foreign key (NIF) references comprador (NIF) on update cascade
);

create table pedido(
Transaccion int primary key,
domicilio varchar(60),
constraint fk_pedido_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table fabricante(
CodFabr int primary key,
Nombre varchar(40) not null,
TiempoEntrega int not null
);

create table aprovisionamiento(
Transaccion int primary key,
CodFabr int not null,
constraint fk_aprovisionamiento_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);


create table comanda(
Transaccion int primary key,
constraint fk_comanda_transaccion foreign key (Transaccion) references actividad (Transaccion) on update cascade
);

create table plato(
codigoplato int primary key,
Nombre varchar(80) not null,
pvp float not null
);

create table lineaplato(
codigoplato int,
Transaccion int,
cantidad int not null,
constraint ch_cantidad check(cantidad>0),
constraint pk_lineaplato primary key (codigoplato, Transaccion),
constraint fk_lineaplato_codigoplato foreign key (codigoplato) references plato (codigoplato) on update cascade,
constraint fk_lineaplato_transaccion foreign key (Transaccion) references comanda (Transaccion) on update cascade
);

create table lineaingrediente(
codigoplato int,
CodigoAlimento int,
cantidad int,
constraint pk_lineaingrediente primary key (codigoplato, CodigoAlimento),
constraint fk_lineaingrediente_codigoplato foreign key (codigoplato) references plato (codigoplato) on update cascade,
constraint fk_lineaingrediente_CodigoAlimento foreign key (CodigoAlimento) references ingrediente (CodigoAlimento) on update cascade
);

create table suministro(
Transaccion int,
CodigoAlimento int,
constraint pk_suministro primary key (Transaccion, CodigoAlimento),
constraint fk_suministro_CodigoAlimento foreign key (CodigoAlimento) references ingrediente (CodigoAlimento) on update cascade,
constraint fk_suministro_transaccion foreign key (Transaccion) references aprovisionamiento (Transaccion) on update cascade
);

create table carta(
NIF char(9),
codigoplato int,
constraint pk_carta primary key (NIF, codigoplato),
constraint fk_carta_nif foreign key (nif) references establecimiento(nif) on update cascade,
constraint fk_carta_codigoplato foreign key (codigoplato) references plato(codigoplato) on update cascade
);

create table fecha(
fecha datetime primary key 
);

create table historicolocal(
NIF char(9),
CodigoAlimento1 int,
CodigoAlimento2 int,
fecha datetime,
probabilidad double,
constraint pk_historicolocal primary key (NIF, CodigoAlimento1, CodigoAlimento2, fecha),
constraint fk_historicolocal_codigoal1 foreign key (NIF,CodigoAlimento1) references stock(NIF,CodigoAlimento) on update cascade,
constraint fk_historicolocal_codigoal2 foreign key (NIF,CodigoAlimento2) references stock(NIF,CodigoAlimento) on update cascade,
constraint fk_historicolocal_fecha foreign key (fecha) references fecha(fecha) on update cascade
);

create table historicoglobal(
CodigoAlimento1 int,
CodigoAlimento2 int,
fecha datetime,
probabilidad double,
constraint pk_historicoglobal primary key (CodigoAlimento1, CodigoAlimento2, fecha),
constraint fk_historicoglobal_codigoal1 foreign key (CodigoAlimento1) references alimento(CodigoAlimento) on update cascade,
constraint fk_historicoglobal_codigoal2 foreign key (CodigoAlimento2) references alimento(CodigoAlimento) on update cascade,
constraint fk_historicoglobal_fecha foreign key (fecha) references fecha(fecha) on update cascade
);


/* Inserciones establecimientos */

insert into establecimiento
values ('12345678H', 'Bar Buenavista', 'Calle buenavista 7', 'Bar') ;

insert into establecimiento
values ('23456789J', 'Ristorante Fuggini', 'Gran V??a 3', 'Restaurante') ;

insert into establecimiento
values ('34567899K', 'Caf?? Manolo', 'Montevideo 4', 'Cafeteria') ;

/* Inserciones Alimentos y productos */

insert into alimento 
values(1, 'Aquarius', 'Bebida', null, '0.35', true,true,true,true,true);

insert into producto
values(1, 2.00);

insert into alimento 
values(2, 'Coca-cola', 'Bebida', null, '0.35', true,true,true,true,true);

insert into producto
values(2, 1.80);

insert into alimento 
values(3, 'Bocata de tortilla', 'Comida', '2021/02/20', '1.00', true,true,false,false,true);

insert into producto
values(3, 2);

insert into alimento 
values(4, 'Ca??a Cerveza Rubia', 'Bebida', '2021/11/20', '0.25', true,true,true,false,true);

insert into producto
values(4, 2.20);

insert into alimento 
values(5, 'Zurito Rubio', 'Bebida', '2021/11/20', '0.15', true,true,true,false,true);

insert into producto
values(5, 1);

insert into alimento 
values(6, 'Cerveza Radler', 'Bebida', '2021/11/20', '0.35', true,true,true,false,true);

insert into producto
values(6, 2.20);

insert into alimento 
values(7, 'Mojito', 'Bebida', '2021/11/20', '2.00', true,true,true,true,true);

insert into producto
values(7, 6);

insert into alimento 
values(8, 'Cubata', 'Bebida', '2021/11/20', '2.00', true,true,true,true,true);

insert into producto
values(8, 6);

insert into alimento 
values(9, 'Sandwich Jam??n y Queso', 'Comida', '2021/03/20', '0.70', false,true,false,true,true);

insert into producto
values(9, 1.60);

insert into alimento 
values(10, 'Patatas Lays', 'Comida', '2021/12/20', '0.30', true,true,true,true,true);

insert into producto
values(10, 2);

insert into alimento 
values(11, 'Caf?? Solo', 'Bebida', '2021/12/20', '0.15', true,true,true,true,true);

insert into producto
values(11, 1.10);

insert into alimento 
values(12, 'Caf?? con leche', 'Bebida', '2021/12/20', '0.25', true,true,false,true,true);

insert into producto
values(12, 1.20);

insert into alimento 
values(13, 'Cola Cao', 'Bebida', '2022/12/20', '0.30', true,true,true,true,true);

insert into producto
values(13, 2);

/* Stock de establecimiento */

insert into stock
values('12345678H', 1, 20);

insert into stock
values('12345678H', 2, 20);

insert into stock
values('12345678H', 3, 20);

insert into stock
values('12345678H', 4, 100);

insert into stock
values('12345678H', 5, 400);

insert into stock
values('12345678H', 6, 100);

insert into stock
values('12345678H', 7, 58);

insert into stock
values('12345678H', 8, 69);

insert into stock
values('12345678H',9 , 9);

insert into stock
values('12345678H', 11, 90);

insert into stock
values('12345678H', 12, 150);

insert into stock
values('12345678H', 10, 14);

insert into stock
values('34567899K', 1, 20);

insert into stock
values('34567899K', 2, 20);

insert into stock
values('34567899K', 3, 20);

insert into stock
values('34567899K', 4, 100);

insert into stock
values('34567899K', 5, 400);

insert into stock
values('34567899K', 6, 100);

insert into stock
values('34567899K', 7, 58);

insert into stock
values('34567899K', 9, 58);

insert into stock
values('34567899K', 8, 69);

insert into stock
values('34567899K', 11, 90);

insert into stock
values('34567899K', 12, 150);

insert into stock
values('34567899K', 10, 14);

insert into stock
values('23456789J', 1, 20);

insert into stock
values('23456789J', 2, 20);

insert into stock
values('23456789J', 3, 20);

insert into stock
values('23456789J', 4, 100);

insert into stock
values('23456789J', 5, 400);

insert into stock
values('23456789J', 6, 100);

insert into stock
values('23456789J', 7, 58);

insert into stock
values('23456789J', 8, 69);

insert into stock
values('23456789J', 11, 90);

insert into stock
values('23456789J', 12, 150);

insert into stock
values('23456789J', 9, 150);

insert into stock
values('23456789J', 10, 14);


/* INSERCIONES PLATOS */
insert into plato
values (1,'Espaguetis a la carbonara', 11.99);

insert into plato
values (2,'Risoto de setas y hongos', 12.95);

insert into plato
values (3,'Ensalada mixta', 8.99);

insert into plato
values (4,'Ensaladilla rusa', 9.99);

insert into plato
values (5,'Milanesa de ternera con queso', 11.99);

insert into plato
values (6,'Pimientos rellenos de bacalao', 9.99);

insert into plato
values (7,'Filete de ternera con patatas', 15.99);

insert into plato
values (8,'Entrecot con pimientos y patatas', 15.99);

insert into plato
values (9,'Brownie con helado ', 7.99);

insert into plato
values (10,'Tarta de queso', 5.99);

insert into plato
values (11,'Tarta tres chocolates', 6.99);

/*Inserciones en la carta*/

insert into carta
values ('23456789J', 1);

insert into carta
values ('23456789J', 2);

insert into carta
values ('23456789J', 3);

insert into carta
values ('23456789J', 4);

insert into carta
values ('23456789J', 5);

insert into carta
values ('23456789J', 6);

insert into carta
values ('23456789J', 7);

insert into carta
values ('23456789J', 8);

insert into carta
values ('23456789J', 9);

insert into carta
values ('23456789J', 10);

insert into carta
values ('23456789J', 11);

/*TRIGGER*/

 delimiter &&
create trigger actualizar1_stock
after insert on lineaproducto 
for each row

begin
	if(select tipo 
    from actividad 
		where Transaccion = New.Transaccion)='APROVISIONAMIENTO'
then
	update stock 
    set cantidad = cantidad + new.Cantidad
		where NIF = (select NIF 
    from actividad 
		where Transaccion = new.Transaccion) and CodigoAlimento = new.CodigoAlimento;
else 
	update stock 
    set cantidad = cantidad - new.Cantidad
		where NIF = (select NIF 
    from actividad 
		where Transaccion = new.Transaccion) and CodigoAlimento = new.CodigoAlimento;
end if;
end; &&

/* FUNCION
El campo boolean comanda sirve para calcular el precio de los platos si es de tipo comanda
*/
delimiter //
create function ImporteTransacion(NumTrans int, comanda boolean) returns double
reads sql data
begin  
	declare totalProductos double default 0;
	declare totalPlatos double default 0;
    
	select sum(TotalProducto) into totalProductos from lineaproducto where transaccion = numtrans;
    
    if comanda = true then   
        select sum(plato.pvp * lineaplato.cantidad) into totalPlatos from plato, lineaplato where plato.codigoplato = lineaplato.codigoplato
        and lineaplato.Transaccion = NumTrans;
	end if;
    
    return round(totalProductos + totalPlatos,2);

end
// 

/* PROCEDIMIENTOS CALCULOS PROBABILIDADES */
delimiter //
create procedure CalculoProbabilidadesGLOBAL() 
begin
	declare alimento1 int default 1;
    declare alimento2 int;
    declare maxCodAl int;
	declare cantTransEnLasQhayAlimento1 int;
	declare vecesAlimento2Respecto1 int;
    declare probabilidad float;
    declare fechaHora timestamp default current_timestamp();
    declare fechaDia date default current_date();

   
    select max(CodigoAlimento) into maxCodAl from alimento;
    
    insert into fecha values(fechaHora);
    
	while alimento1 <= maxCodAl do
    
		select count(transaccion) into cantTransEnLasQhayAlimento1 from lineaproducto 
			where CodigoAlimento = alimento1
			and transaccion in (select transaccion from actividad where fechaDia > (current_date() - 7));
		
        set alimento2 = 1;
        
        while alimento2 <= maxCodAl do        
			if alimento1 != alimento2 then
				select count(transaccion) into vecesAlimento2Respecto1 from lineaproducto 
					where CodigoAlimento = alimento2
					and transaccion in (select transaccion 
					from lineaproducto 
					where CodigoAlimento = alimento1)
					and transaccion in (select transaccion from actividad where fecha > (current_date() - 7));
					
				set probabilidad = round(vecesAlimento2Respecto1/cantTransEnLasQhayAlimento1,2)*100;
				if probabilidad is null then set probabilidad = 0; end if;
				insert into historicoglobal values(alimento1,alimento2,fechaHora,probabilidad);
			end if;
            
			set alimento2 = alimento2 + 1;
            
        end while;
        
        set alimento1 = alimento1 + 1;
        
	end while;
    /* PARA QUE SALTEN EN CASCADA Y NO TENER QUE LLAMAR DESDE LA APP DE MANERA INUTIL E INEFICIENTE */
    call CalculoProbabilidadesLOCAL(fechaHora, fechaDia);
 
end;// 

delimiter //
create procedure CalculoProbabilidadesLOCAL(fechaHora timestamp, fechaDia date) 
begin
	declare alimento1 int default 1;
    declare alimento2 int;
    declare maxCodAl int;
	declare cantTransEnLasQhayAlimento1 int;
	declare vecesAlimento2Respecto1 int;
    declare probabilidad float;
    declare fin boolean default 0;
    declare NIFLOCAL char(9);
    
       
    declare cursor1 cursor for select nif from establecimiento;
    declare continue handler for not found set fin = 1;
    
    select max(CodigoAlimento) into maxCodAl from alimento;
    

    open cursor1;
	fetch cursor1 into NIFLOCAL;

    while fin = 0 do
    
		
		
        set alimento1 = 1;
	
			while alimento1 <= maxCodAl do
			if (select count(*) from stock where nif = niflocal and codigoalimento = alimento1) > 0 then
				select count(transaccion) into cantTransEnLasQhayAlimento1 from lineaproducto 
					where CodigoAlimento = alimento1
					and transaccion in (select transaccion from actividad where nif = niflocal and fechaDia > (current_date() - 7));
				
				set alimento2 = 1;
				
					while alimento2 <= maxCodAl do        
						if alimento1 != alimento2 and (select count(*) from stock where nif = niflocal and codigoalimento = alimento2) > 0 then
							select count(transaccion) into vecesAlimento2Respecto1 from lineaproducto 
								where CodigoAlimento = alimento2
								and transaccion in (select transaccion 
								from lineaproducto 
								where CodigoAlimento = alimento1)
								and transaccion in (select transaccion from actividad where nif = niflocal and fecha > (current_date() - 7));
								
							set probabilidad = round(vecesAlimento2Respecto1/cantTransEnLasQhayAlimento1,2)*100;
                            if probabilidad is null then set probabilidad = 0; end if;
                            /*select concat('Alimento1: ' ,alimento1, ' Alimento2: ', alimento2, ' probabilidad' , probabilidad, ' vecesAlimento2Respecto1: ' ,vecesAlimento2Respecto1, ' cantTransEnLasQhayAlimento1; ',cantTransEnLasQhayAlimento1) mensaje;*/
							insert into historicolocal values(niflocal,alimento1,alimento2,fechaHora,probabilidad);
						end if;
						
						set alimento2 = alimento2 + 1;
					end while;
            end if;
					set alimento1 = alimento1 + 1;       
			end while;
		fetch cursor1 into NIFLOCAL;
		end while;
	close cursor1;
end;// 
