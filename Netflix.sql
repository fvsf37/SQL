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
genero ENUM ('femenino', 'masculino', 'otros'),
primary key (id_actor)
);
INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, genero) VALUES
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

-- Ejercicio 1.- Obtén el nombre de los actores que sean más jóvenes que el protagonista de la película Bright, y más viejos que la protagonista de la pelicula con la tercera mejor puntuación. Ordena los resultados por la fecha de nacimiento de los actores (muestra primero los actores más jóvenes).

select nombre 
from actores 
where fecha_nac > (select a.fecha_nac from actores as a inner join peliculas as p on p.actor=a.id_actor where p.nombre="Bright") 
and fecha_nac < (select a.fecha_nac from actores as a inner join peliculas as p on p.actor=a.id_actor order by nota desc limit 2,1) 
order by fecha_nac desc;

-- Ejercicio 2.- Obtén el identificador de los actores junto a la media de las películas en las que hayan sido protagonistas, siempre y cuando el sueldo de los actores tenga más de 6 cifras, o que hayan nacido en la primera quincena de uno de los primeros 6 meses del año. Ordena los resultados por el sueldo del actor (de mayor a menor).

select a.id_actor, avg(p.nota) 
from peliculas as p inner join actores as a on p.actor=a.id_actor
where char_length(a.sueldo)>6 or (month(a.fecha_nac)<=6 
and day(a.fecha_nac)<=15)
group by a.id_actor 
order by a.sueldo desc;

-- Ejercicio 3.- Obtén el ID de los actores que contengan más de una letra “a” o más de una letra “e” en su nombre, y hayan protagonizado una película con una nota mayor que el triple de la nota de la segunda película con peor nota;

select a.id_actor 
from actores as a inner join peliculas as p on p.actor=a.id_actor 
where (a.nombre like "%a%a%" or a.nombre like "%e%e%") 
and p.nota > 3*(select nota from peliculas order by nota asc limit 1,1);

-- Ejercicio 4.- Obtén el nombre y director de las películas con un nombre terminado por la letra "s", siempre y cuando la duración de esta sea igual o mayor que la película protagonizada por una mujer nacida en el mes de septiembre. Ordena los resultados por el número de caracteres del nombre de la película (de mayor a menor).
    
select nombre, director 
from peliculas 
where duracion >= (select p.duracion from peliculas as p inner join actores as a on p.actor=a.id_actor where month(a.fecha_nac)=9) 
and nombre like "%s" 
order by char_length(nombre) desc;

-- Ejercicio 5.- Obtén el nombre y la duración de las películas que no sean de “comedia” ni “drama”, siempre y cuando el protagonista de estas tenga un sueldo superior a la media de los salarios de los actores con género "Otros". Ordena los resultados por la duración de las películas (de mayor a menor) o en su defecto, por el nombre de las películas (en orden alfabético). Muestra la duración de las películas en segundos, en una columna llamada TIEMPO.
  
select p.nombre, p.duracion*60 AS TIEMPO
from peliculas as p inner join actores as a on p.actor=a.id_actor
where p.genero not in ("comedia", "drama") 
and a.sueldo > (select avg(sueldo) from actores where genero="Otros") 
order by p.duracion desc, p.nombre;