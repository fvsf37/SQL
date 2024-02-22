CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
	nombre VARCHAR(30),
	duracion INT,
	director VARCHAR(20),
	genero ENUM ('acción', 'drama', 'comedia'),
	nota FLOAT,
	actor INT,
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
	(101, 'Leonardo', '1980-12-01' , 3000000, 'masculino'),
	(102, 'Julia', '1997-09-09' , 1000000, 'femenino'),
	(103, 'Brad', '1983-02-02' , 700000, 'masculino'),
	(104, 'Carlos', '1986-03-03' , 250000, 'masculino'),
	(105, 'Santiago', '1970-04-04' , 4000000, 'masculino'),
	(106, 'Penelope', '1976-05-05' , 23000, 'femenino'),
	(107, 'Noa', '1981-06-06' , 770000, 'otros'),
	(108, 'Jon', '1996-07-07' , 6000, 'otros');

INSERT INTO Peliculas (nombre, duracion, director, genero, nota, id_peli, actor) VALUES
	('Bright', 120, 'Fernando', 'acción', 3.1, 1, 101),
	('Frida', 100, 'Daniel', 'drama', 7.6, 2, 101),
	('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 3, 102),
	('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 4, 107),
	('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 5, 104),
	('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 6, 103),
	('El Hoyo', 110, 'Ivan', 'acción', 9.9, 7, 105),
	('Diamante en bruto', 140, 'Paola', 'acción', 7, 8, 101);


-- Ejercicio 1.- Obtén el nombre y la fecha de nacimiento de los actores con un sueldo menor que 1000000 y que su nombre contengan una letra "e" o una letra "n" o tenga menos de 4 caracteres. Ordena el resultado por la fecha de nacimiento de los actores, de mayor a menor.

 select nombre, fecha_nac from actores 
 where sueldo<1000000 and (nombre like "%e%" or nombre like "%n%" or char_length(nombre)<4)
 order by fecha_nac;


-- Ejercicio 2.- Obtén el nombre de los actores que más películas haya rodado junto con el número de películas que haya rodado y que su sexo sea distinto a “Masculino”. Muestra el resultado en dos columnas de nombre ACTOR y PELIS.

select a.nombre as actor, count(p.actor) as pelis
from actores as a
inner join peliculas as p
on a.id_actor=p.actor
where a.sexo not like 'masculino'
group by a.nombre;


-- Ejercicio 3.- Obtén los nombres y sueldos de los actores que cobren más del doble del sueldo "Noa". Muestra los resultados en columnas llamadas NOM_ACTOR Y SUELDO_ACTOR, ordenados por el sueldo de mayor a menor.

select nombre as NOM_ACTOR, sueldo as SUELDO_ACTOR 
from actores where sueldo>2*(select sueldo from actores where nombre="Noa") 
order by sueldo desc;


-- Ejercicio 4.- Obtén el nombre de los actores nacidos un mismo dia y mes, y hayan trabajado en una pelicula dirigida por "Jon", "Adrian", "Nuria" o "Ivan". Muestra el resultado en una columna ACT ordenados por orden alfabético.

select nombre AS ACT 
from actores
where day(fecha_nac)=month(fecha_nac) and id_actor in (select actor from peliculas where director in ("Jon", "Adrian", "Nuria", "Ivan"))
order by nombre;


-- Ejercicio 5.- Obtén todos los datos de las películas que contengan más de un letra "o" en su nombre, su duración sea menor que la duración de "Animales nocturnos" y su puntuación sea mayor que la película del actor Carlos. Ordena los resultados por la nota de la película, de mayor a menor.

select * from peliculas 
where nombre like "%o%o%" 
and duracion <(select duracion from peliculas where nombre="Animales nocturnos") 
and nota >(select p.nota from actores as a inner join peliculas as p on p.actor=a.id_actor where a.nombre="Carlos") 
order by nota desc;
