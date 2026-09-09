select * from estudiantes e

/* =========================================================
   5. PROCEDIMIENTO - CAMBIAR ESTADO DE ESTUDIANTE
   ========================================================= 
   Datos de entrada:
   
   
   Datos de salida:
   
   **/

CREATE OR REPLACE PROCEDURE cambiar_estado_estudiante(
    p_matricula VARCHAR,
    p_estado VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE estudiantes
    SET estado = p_estado
    WHERE matricula = p_matricula;


    IF NOT FOUND THEN

        RAISE EXCEPTION
        'No existe un estudiante con la matrícula %',
        p_matricula;

    END IF;


    RAISE NOTICE
    'Estado del estudiante actualizado correctamente.';

END;
$$;



/* =========================================================
   EJECUTAR PROCEDIMIENTO
   ========================================================= */

CALL cambiar_estado_estudiante(
    '202600001',
    'INACTIVO'
);


/* Verificar */

SELECT
    matricula,
    nombre,
    apellido,
    estado
FROM estudiantes
WHERE matricula = '202600001';


/* Regresarlo a ACTIVO */

CALL cambiar_estado_estudiante(
    '202600001',
    'ACTIVO'
);


select * from grupos

create or replace procedure cambiar_docente_grupo(
	p_id_grupo int,
	p_id_docente int
)
language plpgsql
as $$
begin
	
	update grupos
	set id_docente = p_id_docente
	where id_grupo = p_id_grupo;
	
	IF NOT FOUND THEN

        RAISE EXCEPTION
        'No existe un grupo con ese id %',
       	p_id_grupo;

    END IF;


    RAISE NOTICE
    'Grupo del docente actualizado correctamente.';

end
$$

select * from grupos
where id_grupo = 1;

call cambiar_docente_grupo(1, 2);
















