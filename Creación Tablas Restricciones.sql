-- Ejercicio 1.- Crea una BD de nombre LIGA_EA.
create database LIGA_EA;
use LIGA_EA;

-- Ejercicio 2.- Crea una tabla JUGADOR en la BD LIGA_EA con los siguientes contenidos.
-- DNI: contenido de tipo caracteres. El valor DNI deberá tener exactamente 9 caracteres
-- Nombre: contenido de tipo caracteres (máximo 20 caracteres). El campo Nombre deberá tener 10 caracteres mínimo
-- Apellido: contenido de tipo caracteres (máximo 20 caracteres)
-- Altura: contenido de tipo decimal (máximo 2 decimales). El campo Altura deberá estar entre 1.50 y 2.10
-- Posición: contenido con 4 valores posibles (Portero, Defensa, Medio o Delantero). El campo Posición, por defecto, será NO DEFINIDO
-- Fecha_nacimiento: contenido de tipo fecha. El campo Fecha_nacimiento deberá estar entre marzo y octubre (ambos incluidos)
-- Email: contenido de tipo caracteres (máximo 30 caracteres). El campo Email deberá contener el carácter @
-- Dirección: contenido de tipo caracteres (máximo 100 caracteres). El campo Dirección deberá contener la palabra “Calle o Avenida”
-- Clave: contenido de tipo caracteres (máximo 15 caracteres). El campo Clave deberá tener 8 caracteres mínimo

create table jugador (
dni varchar(9) constraint `chk_dni` check (char_length(dni)=9),
nombre varchar(20) constraint `chk_nombre` check (char_length(nombre)>9),
apellido varchar (20),
altura decimal (3,2) constraint `chk_altura` check (altura between 1.50 and 2.10),
posicion enum ('portero', 'defensa', 'medio', 'delantero', 'no definido') default 'no definido',
fecha_nacimiento date constraint `chk_fecha_nacimiento` check (month(fecha_nacimiento) between 03 and 10),
email varchar(30) constraint `chk_email` check (email like '%@%'),
direccion varchar(100) constraint `chk_direccion` check (direccion like '%calle%' or direccion like '%avenida%'),
clave varchar(15) constraint `chk_clave` check (char_length(clave)=7)
);

-- Ejercicio 3.- Inserta valores en la tabla JUGADOR para comprobar que todas las restricciones se han creado de forma correcta.

insert into JUGADOR (dni, nombre, apellido, altura, posicion, fecha_nacimiento, email, direccion, clave) VALUES
("123456789", "AAABBBCCCDDD", "apellido", 1.80, "Portero", "2000-04-10", "jon@gmail.com", "calle...", "123123123");