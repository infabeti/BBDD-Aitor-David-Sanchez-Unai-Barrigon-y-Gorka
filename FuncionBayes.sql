delimiter //
create procedure calculoBayes(cod1 int, cod2 int) BEGIN

declare porcentaje double;
declare codigo1 int;
declare codigo2 int;

declare cant1 int;
declare cant2 int;

	select count(CodigoAlimento) into codigo1 from lineaproducto where CodigoAlimento = cod1;
	select count(CodigoAlimento) into codigo2 from lineaproducto where CodigoAlimento = cod2;
    
    if codigo1 = 0 then
    
    
    select concat("No hay transacciones disponibles para el codigo ", cod1) "Error";
    
    elseif codigo2 = 0 then

        select concat("No hay transacciones disponibles para el codigo ", cod2) "Error";
	else
    
    select count(Transaccion) into cant1 from lineaproducto where CodigoAlimento = cod1 and Transaccion in (select Transaccion from lineaproducto where CodigoAlimento = cod2);
	select count(Transaccion) into cant2 from lineaproducto where CodigoAlimento = cod2;    
    set porcentaje =  cant1/cant2;
    set porcentaje = porcentaje*100;
    
    select concat(round(porcentaje,2)) "Porcentaje de compra conjunta %";
    
    end if;

end;
//