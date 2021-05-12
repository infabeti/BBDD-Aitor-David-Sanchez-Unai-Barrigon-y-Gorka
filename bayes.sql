delimiter //
create procedure NaiveBayes(codigo int) 
begin

 declare errornotfound boolean default 0;
 declare contador int default 0;
 declare codali int;
 declare cantidad int default 10;
 declare cant1 int;
 declare cant2 int;
 declare porcentaje double;
 declare duplicateEntry boolean default 0;
 
 declare fechaActual date default current_date();
 
 declare C cursor for Select CodigoAlimento from producto order by CodigoAlimento desc;
 declare continue handler for NOT FOUND set errornotfound = 1;
 declare continue handler for 1062 set duplicateEntry = 1;
 
 open C;
 fetch C into codali;
 
 while errornotfound = 0 do
 
   select count(Transaccion) into cant1
		from lineaproducto
		where CodigoAlimento = codigo
		and Transaccion in (select Transaccion
		from lineaproducto
		where CodigoAlimento = codali) order by count(Transaccion) desc;
        
        select count(Transaccion) into cant2
		from lineaproducto
		where CodigoAlimento = codali order by count(Transaccion) desc;
        
	set porcentaje = round((cant1/cant2)*100,2);
    
	set fechaActual = DATE_ADD(fechaActual, interval contador second);
      
  
  
  
    if codali != codigo then

            if porcentaje >= 0 then
            /* VER SI EXISTE ESA FECHA, SI EXISTE NO INSERTAR */
				insert into fecha values(fechaActual);
				insert into historicoglobal values(Codigo,Codali,fechaActual,porcentaje);
				select concat(porcentaje, " Porcentaje de compra conjunta % con ",codali) "Porcentaje de compra conjunta:";
	
            end if;
            
			end if;

        
	fetch C into codali;
  set contador = contador + 1;
  
 end while;
 
end;//