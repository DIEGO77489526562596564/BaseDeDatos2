 create table facultades(
 	id_facultad SERIAL primary key,
 	nombre varchar(150) not null,
 	codigo varchar(10) unique not null,
 	decano varchar(100),
 	telefono varchar(20)
 );
 
 insert into facultades(nombre, codigo, decano, telefono)
 values ('Ingenieria de Desarrollo de Softaware', 'ING', 'Carlos Mendoza', '6122182726'),
 		('Facultad de Ciencias', 'Cie', 'Laura Ramirez', '6122345678'),
 		('Administracion', 'AMD', 'Roberto Lopez', '6123456789');
 
 create table carreras(
 	id_carrera SERIAL primary key,
 	id_facultad int not null,
 	nombre varchar(150) not null,
 	codigo varchar(10) unique not null,
 	duracion_semestres int not null ,
 	estado varchar(20) default 'activa',
 	
 	constraint fk_carrera_facultad
 		foreign key(id_facultad)
 		references facultades(id_facultad)
 );
 	
 insert into carreras(id_facultad, nombre, codigo, duracion_semestres)
 values (4, 'Ingenieria de Desarrollo de Softaware', 'IDS', 8),
 		(4, 'Ingenieria en Tecnologías Computacionales', 'ITC', 8),
 		(5, 'Licenciatura en Biología', 'BIO', 8),
 		(6, 'Licenciatura en Administración', 'LAE', 8);
 
select carreras.nombre as carreras, facultades.nombre as facultades from carreras inner join facultades on carreras.id_facultad = facultades.id_facultad; 

update facultades set nombre = 'Administración' where id_facultad = 6;
 
create table estudiantes (
	id_estudiante SERIAL primary key,
	matricula varchar(20) unique not null,
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	email varchar(100) unique,
	telefono varchar(20),
	fecha_nacimiento date,
	id_carrera int not null,
	fecha_ingreso date default current_date,
	estado varchar(20) default 'activo',
	
	constraint fk_estudiante_carrera
		foreign key (id_carrera)
		references carreras(id_carrera)

);

insert into estudiantes (matricula, nombre, apellido, email, telefono, fecha_nacimiento, id_carrera)
values ('202600001', 'Juan', 'Pérez', 'juan@universidad.mx', '6121111111', '2005-05-16', 5),
		('202600002', 'María', 'López', 'maria@universidad.mx', '6122222222', '2004-08-15', 6),
		('202600003', 'Carlos', 'Ramírez', 'carlos@universidad.mx', '6123333333', '2005-01-20', 7),
		('202600004', 'Ana', 'Torres', 'ana@universidad.mx', '6124444444', '2004-11-03', 8);
 
select * from carreras;

select * from  estudiantes;

select estudiantes.nombre as estudiantes, estudiantes.apellido as apellido, carreras.nombre as carreras from estudiantes join carreras on estudiantes.id_carrera = carreras.id_carrera;










