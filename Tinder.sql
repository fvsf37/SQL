-- Ejercicio 1.- Crea una BD de nombre TINDER.
create database tinder;
use tinder;

-- Ejercicio 2.- Crea una tabla USUARIOS en la BD TINDER con los siguientes contenidos:
-- ID: contenido de tipo numérico
-- El campo ID incrementará automáticamente a partir del número 20 (incluido)
-- Nombre: contenido de tipo caracteres (máximo 15 caracteres). El campo Nombre deberá contener 5 caracteres (mínimo). El campo Nombre deberá contener más de una letra “a”
-- Apellido: contenido de tipo caracteres (máximo 20 caracteres). El campo Apellido deberá terminar por la letra “s” o por la letra “z”. El campo Apellido deberá ser distinto a “Rodriguez”
-- Edad: contenido de tipo numérico (máximo 2 dígitos). El campo Edad deberá ser mayor o igual a 18
-- Orientación: contenido con 3 valores posibles (Heterosexual, Homosexual u Otro). El campo Orientación tendrá “Otro” como valor por defecto 
-- Todos los campos podrán contener valores NULL, a excepción del ID, Nombre y Edad.

create table USUARIOS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    	NOMBRE VARCHAR(15) CONSTRAINT CHK_NOM CHECK(CHAR_LENGTH(NOMBRE)>=5 AND NOMBRE LIKE "%A%A%") not null,
   	 APELLIDO VARCHAR(20) CONSTRAINT CHK_APE CHECK((APELLIDO LIKE "%s" or APELLIDO LIKE "%Z") AND APELLIDO <> "Rodriguez"),
	EDAD INT CONSTRAINT CHK_EDAD CHECK(CHAR_LENGTH(EDAD)<=2 AND EDAD BETWEEN 18 AND 99) not null,
   	ORIENTACION ENUM("heterosexual", "homosexual", "otro") default "otro"
)AUTO_INCREMENT=20;

-- Ejercicio 3.- Crea una tabla LIKES en la BD TINDER con los siguientes contenidos:
-- ID: contenido de tipo numérico. El campo ID incrementará automáticamente a partir del número 100 (no incluido)
-- Fecha: contenido de tipo fecha. El campo Fecha deberá tener un mes impar 
-- Tipo: contenido con 2 valores posibles (Like o Superlike). El campo Tipo tendrá “Like” como valor por defecto 
-- Usuario1: contenido de tipo numérico 
-- Usuario2: contenido de tipo numérico
-- Ninguno de los campos podrá contener valores NULL.

create table LIKES(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    	FECHA DATE CONSTRAINT CHK_FECHA CHECK(MONTH(FECHA) IN ("1", "3", "5", "7", "9", "11")) NOT NULL,
   	TIPO ENUM ("LIKE", "SUPERLIKE") DEFAULT "LIKE",
    	USUARIO1 INT,
    	USUARIO2 INT
)AUTO_INCREMENT=101;

-- Ejercicio 4.- Añade claves foráneas en la tabla LIKES:
-- Haz que la columna Usuario1 referencie a la clave primaria de la tabla USUARIOS
-- Haz que la columna Usuario2 referencie a la clave primaria de la tabla USUARIOS

ALTER TABLE LIKES ADD CONSTRAINT FK_USER1 FOREIGN KEY (USUARIO1) REFERENCES USUARIOS(ID);
ALTER TABLE LIKES ADD CONSTRAINT FK_USER2 FOREIGN KEY (USUARIO2) REFERENCES USUARIOS(ID);

-- Ejercicios 5.- Inserta 3 filas de datos en cada una de las tablas creadas anteriormente y comprueba que los datos se han insertado correctamente.
-- Inserta solamente los DATOS INDISPENSABLES para que no salte ningún error en la propia inserción


insert into usuarios(id, nombre, edad) values(
'21', 'manuela','69'
'22', 'carmena','54'
'23', 'paca','98'
);

insert into likes(id, fecha, usuario1, usuario2) values(
'101', '03-01-2000','01', '04',
'102', '05-03-2000','02', '05',
'103', '08-05-2000','03', '06'
)