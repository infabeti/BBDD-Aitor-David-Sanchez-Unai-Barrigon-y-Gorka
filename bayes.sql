delimiter //
create procedure NaiveBayes(codigo int) begin


 declare errornotfound boolean default 0;
 declare contador int default 0;
 declare codali int;
 declare cantidad int default 10;
 declare cant1 int;
 declare cant2 int;
 declare porcentaje double;
 declare fechaActual datetime default current_timestamp();
 declare C cursor for Select CodigoAlimento from producto order by CodigoAlimento desc;
 
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
    
    
    insert into fecha values(fechaActual);
  insert into historicoglobal (CodigoAlimento1,CodigoAlimento2,fecha,probabilidad) values(Codigo,Codali,fechaActual,porcentaje);
    if codali != codigo then

            if porcentaje >= 0 then
            
				select concat(porcentaje) "Porcentaje de compra conjunta % con ",codali ;
	
            end if;
            

               
    end if;

        
	fetch C into codali;
  set contador = contador + 1;
  
 end while;
 




end
//