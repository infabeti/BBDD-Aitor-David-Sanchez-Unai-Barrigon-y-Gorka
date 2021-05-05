delimiter //
CREATE PROCEDURE calculoBayesLocal (niflocal varchar(9), cod1 int, cod2 int)
BEGIN

declare porcentaje double;
declare nifl char(9);
declare cant1 int;
declare cant2 int;
declare trans1 int;
declare trans2 int;

declare errornotfound boolean default 0;
declare continue handler for not found set errornotfound = 1;



select NIF into nifl from establecimiento where NIF = niflocal;



	if errornotfound = 1 then

		select concat("No existe un local con el NIF ", niflocal, " en la base de datos") "Error NIF";
        
	else
        select count(Transaccion) into trans1 from lineaproducto where CodigoAlimento = cod1;
        
			if cod1 not in(Select CodigoAlimento from stock where NIF=niflocal) then
        
          
				select concat("No existe un alimento con el código ",cod1," introducido en el local introducido") "Error Stock";
                        
                        
                   
                        
			elseif  trans1=0 then
         
         
				select concat("No hay transacciones disponibles para el codigo ", cod1) "Error";
        
        
			else
        
				select count(Transaccion) into trans2 from lineaproducto where CodigoAlimento = cod2;
                
                if cod2  not in(Select CodigoAlimento from stock where NIF=niflocal) then
        
        
					select concat("No existe un alimento con el código ",cod2," introducido en el local introducido") "Error Stock";
     

				elseif trans2 = 0  then
         
         
					select concat("No hay transacciones disponibles para el codigo ", cod2) "Error";
		
				else
        
         select count(Transaccion) into cant1
		from lineaproducto
		where CodigoAlimento = cod1
		and Transaccion in (select Transaccion
		from lineaproducto
		where CodigoAlimento = cod2);
 
		select count(Transaccion) into cant2
		from lineaproducto
		where CodigoAlimento = cod1;
 
		set porcentaje =  cant1/cant2;
		set porcentaje = porcentaje*100;
 
    select concat(round(porcentaje,2)) "Porcentaje de compra conjunta %";
        
        
		end if;

		end if;
        
        end if;
        


end
//