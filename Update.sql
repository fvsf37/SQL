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

-- Ejercicio 1.- Modifica las horas de la tabla GRADO añadiendo 100 horas a cada uno de los grado

update grado set horas=horas+100;

-- Ejercicio 2.- Modifica las horas de la tabla GRADO dividiendo las horas entre 2 a los grados que sean de segundo curso, es decir, que contengan el número 2 en su nombre.

update grado set horas=horas/2 where nombre like "%2%";

-- Ejercicio 3.- Modifica el apellido de los alumnos a NULL cuando el apellido contenga más de 8 caracteres, o el nombre tenga más de una letra "e".

update alumno set apellido=NULL where char_length(apellido)>8 or nombre like "%e%";

-- Ejercicio 4.- Modifica el apellido de los alumnos, añadiendo el valor del nombre dentro del valor del apellido. Es decir, a partir de ahora el apellido mostrara el propio apellido, seguido del nombre del alumno.

update alumno set apellido=concat(apellido, " ", nombre);

-- Ejercicio 5.- Modifica el valor de la columna grado de la tabla alumno para que el valor por defecto sea del del identificador de SMR1.

update alumno set grado=(select id from grado where nombre="SMR1");

-- Ejercicio 6.- Modifica el grado del alumno con una edad mayor que 35, para que el grado coincida con el que más horas tenga de la tabla Grado.

update alumno set grado=(select ID from grado order by horas desc limit 1) where edad>35;

-- Ejercicio 7.- Modifica el nombre del alumno "Jon" para que el valor de este apareza con un prefijo "Don" en la tabla.

update alumno set nombre=concat("Don ", nombre) where nombre like "jon";

-- Ejercicio 8.- Modifica el grado del alumno con 4 caracteres en su nombre para que el valor del grado sea igual al grado con ID menor que el grado de DAW2.

update alumno set grado=(select id from grado where id<(select id from grado where nombre="DAW2")) where char_length(nombre) like 4;
