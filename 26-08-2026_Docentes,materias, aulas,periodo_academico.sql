select * from estudiantes e
select * from facultades f 
select * from carreras

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
		(8, 'ITC101', 'Redes de Computadoras', 7, 'Obligatoria', 'Fundamentos de redes');

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



