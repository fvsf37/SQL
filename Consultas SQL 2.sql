
CREATE DATABASE POKEMON_GO;
USE POKEMON_GO;

CREATE TABLE POKEMON (
	ID int primary key not null,
    	Nombre varchar(15),
    	Tipo enum("ROCA","TIERRA","PLANTA"),
    	Altura decimal(4,2),
    	Edad decimal (3,0),
    	Fecha_nac DATE
);

INSERT INTO POKEMON VALUES
	(1, 'JON', 'TIERRA', '1.20', '123', '2001-12-30'),
	(2,'MARCOS', 'TIERRA', '1.40', '11', '2012-10-18'),
	(3, 'CELIA', 'PLANTA', '1.00', '29', '2000-02-02'),
	(4, 'JUANMA', 'ROCA', '2.15', '32', '1999-01-01'),
	(5, 'JAVIER', 'TIERRA', '0.90', '2', '2002-07-12'),
	(6, 'CARMEN', 'PLANTA', '2.42', '14', '1997-03-27');


-- Ejercicio 1.- Muestra el nombre de todos los Pokemon que sean de tipo tierra.

select * 
from POKEMON 
where Tipo="TIERRA";

-- Ejercicio 2.- Muestra el ID de los Pokemon de nombre Camen o de altura mayor que 2

select ID 
from POKEMON 
where Nombre="Carmen" or Altura > 2;

-- Ejercicio 3.- Muestra el tipo de los Pokemon con edad distinta a 32 sin que se repitan datos en el resultado.

select distinct(Tipo) 
from POKEMON 
where Edad <>32;

-- Ejercicio 4.- Muestra el nombre y tipo de los Pokemon que hayan nacido en el año 2000 o 2001 ordenador alfabéticamente por el nombre.

select Nombre, Tipo 
from POKEMON 
where Fecha_nac like "2000%" or Fecha_nac like "2001%" 
order by Nombre;

-- Ejercicio 5.- Muestra el ID de los Pokemon que su nombre comience por la letra "C" y contengan la letra "A" ordenador por el nombre del Pokemon.

select ID 
from POKEMON 
where Nombre like "C%" and Nombre like "%A%" 
order by Nombre;

-- Ejercicio 6.- Muestra todos pokemon que hayan nacido en el mes de octubre o su edad esté entre 29 y 35 años (ambos incluidos).

select * 
from POKEMON 
where Fecha_nac like "%-10-%" or (Edad>=29 and Edad<=35);

-- Ejercicio 7.- Muestra El ID y la altura de los 2 Pokemon de mayor altura que en su nombre no contengan la letra "E" ordenados por la altura de mayor a menor.

select ID, Altura 
from POKEMON where Nombre not like "%E%" 
order by Altura DESC LIMIT 2;

-- Ejercicio 8.- Muestra todos los datos de los Pokemon que sean de tipo PLANTA o ROCA, tengan una altura superior a 1.50 y su edad sea distina a 14.

select * 
from POKEMON 
where (Tipo = "PLANTA" or TIPO="ROCA") and Altura > 1.50 and Edad <> 14;

-- Ejercicio 9.- Muestra los datos de los 3 Pokemon de menor edad que su nombre tenga una longitud exacta de 6 caracteres. Ordena el resultado de menor a mayor.

select * 
from POKEMON 
where length(Nombre)=6 
order by Edad 
LIMIT 3;

-- Ejercicio 10.- Muestra el ID, Nombre y Edad de los Pokemon con un nombre que comience por la letra J, contenga una letra "M" y termine por la letra "A", o que su edad se muestre con un solo caracter. Ordena los resultados alfabéticamente por el nombre del Pokemon.

select ID, Nombre, Edad 
from POKEMON 
where Nombre like "J%M%A" or length(Edad)=1 
order by Nombre;
