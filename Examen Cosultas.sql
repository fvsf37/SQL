create database examenPrueba;
use examenPrueba;
create table Alumnos (
DNI varchar(11),
Nombre varchar(10),
Apellido varchar(10),
Edad int,
Ciudad varchar(10)
);
create table Productos (
DNI varchar(11),
NumProductos int
);
INSERT INTO Alumnos VALUES
('47657450-L','Jon','Zamora','29','Irun'),
('47657450-L','Jon','Zamora','29','Madrid'),
('42000201-T','Daniel','García','31','Cancun'),
('32120101-F','Fernando','López','19','Madrid'),
('10000000-R','Ramiro','Ramiro','21','Bilbao'),
('10000000-R','Ramiro','Ramiro','21','Barcelona'),
('44566812-M','Marius','Mario','20','Irun');
INSERT INTO Productos VALUES
('47657450-L','4'),
('44566812-M','1'),
('42000201-T','0'),
('32120101-F','0'),
('10000000-R','2');
-- Ejercicio 1.- Realiza una consulta que devuelva todos los datos ordenados alfabéticamente por el nombre del alumno.
SELECT * FROM ALUMNOS 
ORDER BY NOMBRE;

-- Ejercicio 2.- Realiza una consulta que devuelva la media de edad de los alumnos, en una columna que se denomine “MediaEdad”.
SELECT AVG(EDAD) AS MEDIAEDAD 
FROM ALUMNOS;

-- Ejercicio 3.- Realiza una consulta que devuelva los datos de todos los alumnos que tengan un nombre que comience por la letra “J” y tengan un apellido que contenga la letra “a”.
SELECT * FROM ALUMNOS 
WHERE NOMBRE 
LIKE "J%" and APELLIDO LIKE "%A%";

-- Ejercicio 4.- Realiza una consulta que devuelva los alumnos que vivan en la ciudad Irun, Madrid o Bilbao.
SELECT * FROM ALUMNOS 
WHERE CIUDAD 
IN ("MADRID", "IRUN", "BILBAO");

-- Ejercicio 5.- Realiza una consulta que devuelva el nombre, apellido y edad de los 3 alumnos con mayor edad, ordenados de mayor a menor edad.
SELECT NOMBRE, APELLIDO, EDAD 
FROM ALUMNOS 
ORDER BY EDAD DESC LIMIT 3;

-- Ejercicio 6.- Realiza una consulta que devuelva el número de alumnos integrados en la base de datos, en una columna que se denomine “NºAlumnos”.
SELECT COUNT(*) AS NALUMNOS 
FROM ALUMNOS;

-- Ejercicio 7.- Realiza una consulta que devuelva el número de productos comprados por cada alumno, siempre que el alumno haya realizado alguna compra. La consulta debe devolver el nombre del alumno junto al número de compras realizadas por este.
SELECT A.NOMBRE, P.NUMPRODUCTOS 
FROM ALUMNOS AS A INNER JOIN PRODUCTOS AS P ON A.DNI=P.DNI 
WHERE P.NUMPRODUCTOS > 0;

-- Ejercicio 8.- Realiza una consulta que devuelva los alumnos que tengan entre 22 y 29 años (ambos NO incluidos).
SELECT * FROM ALUMNOS 
WHERE EDAD 
BETWEEN 23 AND 28;

-- Ejercicio 9.- Realiza una consulta que devuelva el DNI de los alumnos con el mismo nombre y apellido.
SELECT DISTINCT DNI 
FROM ALUMNOS 
WHERE NOMBRE 
LIKE APELLIDO;

-- Ejercicio 10.- Realiza una consulta que devuelva el número máximo y el número mínimo de productos de la tabla Pedidos, en dos columnas correspondientes denominadas “NºMáximo” y “Nºmínimo”.
SELECT MAX(NUMPRODUCTOS) AS MAXIMO, MIN(NUMPRODUCTOS) AS MINIMO 
FROM PRODUCTOS;