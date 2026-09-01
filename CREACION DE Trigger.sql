create or replace function limite_monto_pago()
returns trigger
as $$
begin
	if new.monto >=20000 then 
		raise exception 'El monto supera el limite';

	end if; 
	return new;
	
end
$$ language plpgsql;

create trigger tgr_validar_monto_pago
before insert 
on pagos
for each row 
execute function limite_monto_pago();

INSERT INTO pagos (id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values (5, 2, 'Inscripción', 3500.00, 'Tarjeta', 'REF001');

INSERT INTO pagos (id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values (5, 2, 'Inscripción', 21000.00, 'Tarjeta', 'REF001');