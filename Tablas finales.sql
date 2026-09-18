select * from estudiantes e
select * from facultades f 
select * from carreras
select * from periodos_academicos

CREATE TABLE docentes ( 
	id_docente SERIAL PRIMARY KEY, 
	numero_empleado VARCHAR(20) UNIQUE NOT NULL, 
	nombre VARCHAR(100) NOT NULL, 
	apellido VARCHAR(100) NOT NULL, 
	email VARCHAR(100) UNIQUE, telefono VARCHAR(20), 
	id_facultad INT NOT NULL, 
	es_tiempo_completo BOOLEAN DEFAULT FALSE,
	
	CONSTRAINT fk_docente_facultad
	    FOREIGN KEY (id_facultad)
	    REFERENCES facultades(id_facultad)
);

INSERT INTO docentes (numero_empleado, nombre, apellido, email, telefono, id_facultad, es_tiempo_completo) 
VALUES ('EMP001', 'Pedro', 'Martínez', 'pedro@universidad.mx', '6125551111', 4, TRUE), 
		('EMP002', 'Sofía', 'Hernández', 'sofia@universidad.mx', '6125552222', 5, TRUE), 
		('EMP003', 'Miguel', 'García', 'miguel@universidad.mx', '6125553333', 6, FALSE);

select * from docentes d 

CREATE TABLE materias (
    id_materia SERIAL PRIMARY KEY,
    id_carrera INT NOT NULL,
    clave VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    creditos INT NOT NULL,
    tipo VARCHAR(50),
    descripcion TEXT,

    CONSTRAINT fk_materia_carrera
        FOREIGN KEY (id_carrera)
        REFERENCES carreras(id_carrera)
);

INSERT INTO materias (id_carrera, clave, nombre, creditos, tipo, descripcion)
values	(5, 'IDS101', 'Metodología de la Programación', 8, 'Obligatoria', 'Fundamentos de programación'),
		(6, 'IDS201', 'Programación Web', 8, 'Obligatoria', 'Desarrollo de aplicaciones web'),
		(7, 'IDS301', 'Base de Datos II', 8, 'Obligatoria', 'Bases de datos avanzadas'),
		(8, 'ITC401', 'Redes de Computadoras', 7, 'Obligatoria', 'Fundamentos de redes');

select * from materias

CREATE TABLE aulas (
    id_aula SERIAL PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    edificio VARCHAR(100),
    capacidad INT NOT NULL,
    tipo VARCHAR(50)
);

INSERT INTO aulas (codigo, edificio, capacidad, tipo)
values	('A-101', 'Edificio A', 30, 'Laboratorio'),
		('A-102', 'Edificio A', 40, 'Aula'),
		('B-201', 'Edificio B', 25, 'Laboratorio'),
		('B-202', 'Edificio B', 35, 'Aula');

CREATE TABLE periodos_academicos (
    id_periodo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVO'
);

INSERT INTO periodos_academicos	(nombre, fecha_inicio, fecha_fin, estado)
values	('2026-1', '2026-01-20', '2026-06-15', 'FINALIZADO'),
		('2026-2', '2026-08-10', '2026-12-15', 'ACTIVO');

CREATE TABLE grupos (
    id_grupo SERIAL PRIMARY KEY,
    id_materia INT NOT NULL,
    id_docente INT NOT NULL,
    id_periodo INT NOT NULL,
    id_aula INT NOT NULL,
    grupo VARCHAR(10) NOT NULL,
    horario VARCHAR(100),
    cupo_maximo INT DEFAULT 30,

    CONSTRAINT fk_grupo_materia
        FOREIGN KEY (id_materia)
        REFERENCES materias(id_materia),

    CONSTRAINT fk_grupo_docente
        FOREIGN KEY (id_docente)
        REFERENCES docentes(id_docente),

    CONSTRAINT fk_grupo_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT fk_grupo_aula
        FOREIGN KEY (id_aula)
        REFERENCES aulas(id_aula)
);

INSERT INTO grupos	(id_materia, id_docente, id_periodo, id_aula, grupo, horario, cupo_maximo)
values	(1, 1, 2, 1, 'A', 'Lunes y Miércoles 08:00-10:00', 30),
		(2, 2, 2, 2, 'B', 'Martes y Jueves 10:00-12:00', 35),
		(3, 1, 2, 3, 'C', 'Lunes y Miércoles 12:00-14:00', 25);

select * from grupos;

CREATE TABLE inscripciones (
    id_inscripcion SERIAL PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_grupo INT NOT NULL,
    id_periodo INT NOT NULL,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'INSCRITO',

    CONSTRAINT fk_inscripcion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante),

    CONSTRAINT fk_inscripcion_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupos(id_grupo),

    CONSTRAINT fk_inscripcion_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT uq_estudiante_grupo
        UNIQUE(id_estudiante, id_grupo)
);

INSERT INTO inscripciones (id_estudiante, id_grupo, id_periodo)
values	(5, 1, 2);

CREATE TABLE calificaciones (
    id_calificacion SERIAL PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    calificacion DECIMAL(5,2),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    observaciones TEXT,
    tipo_evaluacion VARCHAR(50),

    CONSTRAINT fk_calificacion_inscripcion
        FOREIGN KEY (id_inscripcion)
        REFERENCES inscripciones(id_inscripcion),

    CONSTRAINT chk_calificacion
        CHECK (calificacion >= 0 AND calificacion <= 100)
);

INSERT INTO calificaciones (id_inscripcion, calificacion, observaciones, tipo_evaluacion)
values (27, 90, 'Buen desempeño', 'Final');

select * from inscripciones;

CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_periodo INT NOT NULL,
    concepto VARCHAR(100) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(30),
    referencia VARCHAR(100),
    estado VARCHAR(20) DEFAULT 'PAGADO',

    CONSTRAINT fk_pago_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiantes(id_estudiante),

    CONSTRAINT fk_pago_periodo
        FOREIGN KEY (id_periodo)
        REFERENCES periodos_academicos(id_periodo),

    CONSTRAINT chk_monto
        CHECK (monto > 0)
);

INSERT INTO pagos (id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia)
values (5, 2, 'Inscripción', 3500.00, 'Tarjeta', 'REF001');

select * from pagos;

select 
estudiantes.nombre as estudiante, 
materias.nombre as materias
from estudiantes
join materias 
on estudiantes.id_carrera = materias.id_carrera 
where estudiantes.id_estudiante = 5;

select
grupos.id_grupo as id_grupo,
materias.nombre as nombre_materia,
grupos.grupo as nombre_grupo,
grupos.cupo_maximo as cupo_maximo,
count(inscripciones.id_inscripcion) as cantidad_alumnos
from grupos
inner join materias 
on grupos.id_materia = materias.id_materia 
left join inscripciones 
on grupos.id_grupo = inscripciones.id_grupo 
and inscripciones.estado = 'INSCRITO'
group by 
grupos.id_grupo,
materias.nombre,
grupos.grupo,
grupos.cupo_maximo;

select
estudiantes.matricula as matricula,
estudiantes.nombre as nombre,
estudiantes.apellido as apellido,
pagos.concepto as concepto,
pagos.monto as monto,
pagos.metodo_pago as metodo_pago,
pagos.referencia as referencia
from estudiantes 
inner join pagos
on estudiantes.id_estudiante = pagos.id_estudiante;


create table acceso(
	id_acceso serial primary key,
	id_estudiante int not null,
	correo varchar(50) not null,
	contraseña varchar (50) not null,

	constraint fk_acceso_estudiante
		foreign key (id_estudiante)
		references estudiantes(id_estudiante)
		
);

INSERT INTO acceso (id_estudiante, correo, contraseña)
VALUES (5, 'alumno@universidad.com', '123456');

select * from acceso

create or replace procedure validar_acceso(
	c_correo varchar,
	c_contraseña varchar

)
language plpgsql
as $$
begin
	
	if exists(
		select 1
		from acceso
		where correo = c_correo
		and contraseña = c_contraseña
	)then 
		raise notice 'Acceso Correcto';
	
	else 
		raise exception 'Acceso Denegado';
	end if;
		
	
end;
$$;

call validar_acceso('alumno@universidad.com', '123456');
call validar_acceso('alumno@universidad.com', '55555');


















