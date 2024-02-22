Create database cesur;
use cesur;

CREATE TABLE ALUMNO(
	DNI  varchar(9),
	nombre varchar(15), 
	apellido varchar(20), 
	edad INT,
	PRIMARY KEY(DNI)
	);
    
CREATE TABLE GRADO(
	ID INT,
	nombre varchar(15), 
	horas INT,
	PRIMARY KEY(ID)
	);
    
INSERT INTO ALUMNO (DNI, nombre, apellido, edad) values 
	('44566835T', 'jon', 'zamora', 32),
	('44576835T', 'manuel', 'fernandez', 22),
	('43466835T', 'lorena', 'aleman', 20),
	('42166835T', 'pepe', 'gavilan', 18),
	('41166835T', 'celia', 'flores', 40);
        
INSERT INTO GRADO (ID, nombre, horas) values 
	(001, 'DAM1', 430),
	(002, 'DAW2',  300),
	(003, 'ASIR1',  500),
	(004, 'SMR1', 300),
	(005, 'SMR2', 270);
  
        
ALTER TABLE ALUMNO ADD COLUMN grado int,
ADD CONSTRAINT `fk_id_grado` FOREIGN KEY (grado) REFERENCES GRADO (id); 

-- Ejercicio 1.- Añade una nueva columna (no nula) “Ciudad” a la tabla ALUMNO de tipo caracteres (máximo 15 caractéres) que por defecto tenga “Malaga” como valor. 

alter table alumno add column ciudad varchar(15) default 'malaga' not null;

-- Ejercicio 2.- Modifica la columna “Ciudad” para que acepte valores nulos.

alter table alumno modify column ciudad varchar(15);

-- Ejercicio 3.- Modifica la columna “Ciudad” para que acepte valores de hasta 25 caracteres.

alter table alumno modify column ciudad varchar(25);

-- Ejercicio 4.- Modifica el nombre de la columna “Ciudad” a “Localidad”.

alter table alumno change column ciudad localidad varchar(25);

-- Ejercicio 5.- Añade una nueva columna “Media” en la tabla ALUMNO que sea de tipo decimal (con un decimal máximo) y pueda tener una nota máxima de 9,9.

alter table alumno add column media decimal(2,1);

-- Ejercicio 6.- Modifica la columna “Media” para que acepte valores con 2 decimales, tenga el valor 0,0 por defecto y no pueda ser NULL.

alter table alumno modify column media decimal (3,2) default 0.0 not null;

-- Ejercicio 7.- Elimina la restricción de clave foranea de la columna Grado de la tabla ALUMNO.

alter table alumno drop foreign key `fk_id_grado`;

-- Ejercicio 8.- Elimina la restricción de clave primaria de la columna DNI de la tabla ALUMNO.

alter table alumno drop primary key;

-- Ejercicio 9.- Elimina la columna Grado de la tabla ALUMNO.

alter table alumno drop column grado;

-- Ejercicio 10.- Añade una clave primaria a la tabla ALUMNOS_CESUR que sea un entero y se incremente de forma automática.

alter table alumno add column id int primary key auto_increment;

-- Ejercicio 11.- Añade una restricción a la columna Nombre de la tabla GRADO para que los valores del nombre siempre contenga el número 1 o el número 2.

alter table grado add constraint `chk_nombre` check (nombre like '%1%' or nombre like '%2%');

-- Ejercicio 12- Elimina la restricción de la columna Nombre de la tabla GRADO
alter table grado drop constraint `chk_nombre`;

-- Ejercicio 13.- Modifica el nombre de la tabla GRADO a CICLO.

alter table grado rename ciclo;