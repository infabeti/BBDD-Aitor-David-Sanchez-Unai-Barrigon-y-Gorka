delimiter //
create procedure CalculoProbabilidades() 
begin
	declare alimento1 int default 1;
    declare alimento2 int;
    declare maxCodAl int;

	declare cantTransEnLasQhayAlimento1 int;
	declare vecesAlimento2Respecto1 int;
    declare probabilidad float;
	declare fechaHora timestamp default current_timestamp();

   
    select max(CodigoAlimento) into maxCodAl from alimento;
    insert into fecha values(fechaHora);
    
	while alimento1 <= maxCodAl do
    
		select count(transaccion) into cantTransEnLasQhayAlimento1 from lineaproducto 
			where CodigoAlimento = alimento1
			and transaccion in (select transaccion from actividad where fecha > (current_date() - 7));
		
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
				insert into historicoglobal values(alimento1,alimento2,fechaHora,probabilidad);
			end if;
            
			set alimento2 = alimento2 + 1;
            
        end while;
        
        set alimento1 = alimento1 + 1;
        
	end while;
 
end;// 

call calculoProbabilidades();