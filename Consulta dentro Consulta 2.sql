CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
    	nombre_peli VARCHAR(30),
    	duracion INT,
   	director_peli VARCHAR(20),
    	genero_peli ENUM ('acción', 'drama', 'comedia'),
    	nota_peli FLOAT,
	protagonista int,
    	primary key (id_peli)
);


CREATE TABLE IF NOT EXISTS Actores(
	id_actor INT,
    	nombre VARCHAR(30),
    	fecha_nac DATE,
    	sueldo INT,
    	sexo ENUM ('femenino', 'masculino', 'otros'),
    	primary key (id_actor)
);

INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, sexo) VALUES
(101, 'Leonardo', '1980/12/01' , 3000000, 'masculino'),
(102, 'Julia', '1997/09/09' , 1000000, 'femenino'),
(103, 'Brad', '1983/02/02' , 700000, 'masculino'),
(104, 'Carlos', '1986/03/03' , 250000, 'masculino'),
(105, 'Santiago', '1970/04/04' , 4000000, 'masculino'),
(106, 'Penelope', '1976/05/05' , 23000, 'femenino'),
(107, 'Noa', '1981/06/06' , 770000, 'otros'),
(108, 'Jon', '1996/07/07' , 6000, 'otros');

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, genero_peli, nota_peli, id_peli, protagonista) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1, 103),
('Frida', 100, 'Daniel', 'drama', 7.6, 2, 107),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 3, 103),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 4, 101),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 5, 102),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 6, 102),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 7, 105),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 8, 108);

-- Ejercicio 1.- Obtén todos los datos de los actores con un sueldo menor que el sueldo de Penelope, y que hayan rodado una película de acción.

SELECT A.* 
FROM ACTORES AS A INNER JOIN PELICULAS AS P ON A.ID_ACTOR=P.PROTAGONISTA 
WHERE A.SUELDO < (SELECT SUELDO FROM ACTORES WHERE NOMBRE="PENELOPE") AND P.GÉNERO_PELI="ACCION";

-- Ejercicio 2.- Obtén el id y nombre del actor que haya rodado una película del mismo género que la película rodada por Jon, y en la columna sexo tenga el valor Femenino.

SELECT DISTINCT A.ID_ACTOR, A.NOMBRE 
FROM ACTORES AS A INNER JOIN PELICULAS AS P ON A.ID_ACTOR=P.PROTAGONISTA 
WHERE P.GÉNERO_PELI=(SELECT P.GÉNERO_PELI FROM ACTORES AS A INNER JOIN PELICULAS AS P ON A.ID_ACTOR=P.PROTAGONISTA WHERE P.DIRECTOR_PELI="jon") and A.SEXO="FEMENINO";

-- Ejercicio 3.- Obtén el nombre de los actores que tengan menos caracteres que el actor con id 104, ordenador por la fecha de nacimiento de menor a mayor.

SELECT NOMBRE 
FROM ACTORES 
WHERE CHAR_LENGTH(NOMBRE) < (SELECT CHAR_LENGTH(NOMBRE) FROM ACTORES WHERE ID_ACTOR=104) 
ORDER BY FECHA_NAC DESC;

-- Ejercicio 4.- Obtén el número total de películas rodadas por cada actor, siempre y cuando no hayan nacido en el mes de febrero o marzo. Muestra los datos en dos columnas de nombre ACTOR y TOTAL.

SELECT A.NOMBRE AS ACTOR, COUNT(P.PROTAGONISTA) AS TOTAL 
FROM ACTORES AS A INNER JOIN PELICULAS AS P ON A.ID_ACTOR=P.PROTAGONISTA 
WHERE MONTH(A.FECHA_NAC) NOT IN (2, 3)
GROUP BY A.NOMBRE;

-- Ejercicio 5.- Obtén el nombre de las películas con menor duración que la tercera película con mayor duración de la tabla.

SELECT NOMBRE_PELI 
FROM PELICULAS 
WHERE DURACION <(SELECT DURACION FROM PELICULAS ORDER BY DURACION DESC LIMIT 2,1);

-- Ejercicio 6.- Obtén el nombre de las películas que contengan más de un letra "a" en su nombre y no hayan sido protagonizadas por el actor con sexo masculino y el máximo id.

SELECT NOMBRE_PELI 
FROM PELICULAS 
WHERE PROTAGONISTA != (SELECT ID_ACTOR FROM ACTORES WHERE SEXO="MASCULINO" ORDER BY ID_ACTOR DESC LIMIT 1) AND NOMBRE_PELI LIKE "%a%a%";

-- Ejercicio 7.- Obtén los datos del actor con el mismo nombre que el director de la película con menor puntuación de la tabla Películas.

SELECT * 
FROM ACTORES 
WHERE NOMBRE=(SELECT DIRECTOR_PELI FROM PELICULAS ORDER BY NOTA_PELI LIMIT 1);