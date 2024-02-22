-- Ejercicio 1.- Crea una BD de nombre POKEMON_GO.
create database pokemon_go;
use pokemon_go;

-- Ejercicio 2.- Crea una tabla POKEMON en la base de datos POKEMON_GO.
-- Id: identificador de tipo numérico (PK). El campo ID deberá ser un valor que incremente de forma automática y comience por el número 100
-- Nombre: contenido de tipo caracteres (máximo 15 caracteres). El campo Nombre no podrá estar formado por 2 o más palabras compuestas
-- Altura: contenido de tipo decimal (2 decimales). El campo Altura deberá estar entre 0.50 y 3.50 (ambos no incluidos)
-- Edad: contenido de tipo numérico. El campo Edad deberá estar entre 1 y 100 (ambos incluidos)
-- Fecha_nac: contenido de tipo fecha
-- *Todos los campos podrán contener valores NULL, a excepción del ID y la fecha de nacimiento del Pokemon

create table POKEMON(
	id int primary key auto_increment,
    nombre varchar(15) constraint `chk_nombre` check (nombre not like "% %"),
    altura decimal(3,2) constraint `chk_altura` check (altura between 0.51 and 3.49),
    edad int constraint `chk_edad` check (edad between 1 and 100),
    fecha_nacimiento date not null
)auto_increment=100;

-- Ejercicio 3.- Crea una tabla ENTRENADOR en la base de datos POKEMON_GO.
-- DNI: identificador de tipo caracteres (PK). El campo DNI deberá contener una letra (mínimo)
-- Nombre: contenido de tipo caracteres (máximo 15 caracteres). El campo Nombre, por defecto, tendrá valor NULL
-- Apellido: contenido de tipo caracteres (máximo 20 caracteres). El campo Apellido, deberá contener más de una letra “a”
-- Género: contenido con 3 valores posibles (masculino, femenino u otro)
-- Pokemon: contenido de tipo numérico
-- *Todos los campos podrán contener valores NULL, a excepción del DNI y Género

create table ENTRENADOR(
	DNI varchar(9) primary key constraint `chk_DNI` check (DNI regexp '[a-z]'),
    nombre varchar(15) default NULL,
    apellido varchar(20) constraint `chk_apellido` check (apellido like "%a%a%"),
    genero enum ("masculino", "femenino", "otro") not null,
    pokemon int  
);

-- Ejercicio 6.- Haz que la columna Pokemon de la tabla ENTRENADOR sea clave foranea de la tabla POKEMON.

alter table entrenador add constraint `fk_pokemon` foreign key (pokemon) references pokemon(id);

-- Ejercicios 7.- Inserta 5 filas de datos en cada una de las tablas y comprueba que los datos se han insertado correctamente.