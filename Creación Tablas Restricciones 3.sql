-- Ejercicio 1.- Crea una BD de nombre CONCESIONARIO.
create database concesionario;
use concesionario;

-- Ejercicio 2.- Crea una tabla COCHE en la base de datos CONCESIONARIO y añade las siguientes columnas:
-- ID: identificador de tipo numérico (PK). El campo ID deberá ser un valor que incremente de forma automática y comience por el número 2000
-- Matricula: contenido de tipo caracteres (máximo 8 caracteres). El campo Matrícula deberá tener exactamente 8 caracteres. El campo Matrícula deberá contener el símbolo “-”. El campo Matrícula será un campo único
-- Precio: contenido de tipo decimal (2 decimales). El campo Precio deberá estar entre 10000,00 y 100000,00 (ambos incluidos)
-- Color: contenido con 5 valores posibles  (negro, blanco, azul, rojo o gris). El campo Color tendrá por defecto el valor “negro”
-- *Todos los campos podrán contener valores NULL, a excepción del ID y la Matrícula de los coches

create table coche(
id int auto_increment primary key,
matricula varchar(8) constraint chk_matricula check(char_length(matricula)=8 and matricula like "%-%") unique,
precio decimal(8,2) constraint chk_precio check(precio between 10000 and 100000),
color enum ("negro", "blanco", "azul", "rojo", "gris") default "negro"
)auto_increment=2000;

-- Ejercicio 3.- Crea una tabla VENDEDOR en la base de datos CONCESIONARIO añade las siguientes columnas:
-- DNI: identificador de tipo caracteres (máximo 9 caracteres) (PK). El campo DNI deberá tener exactamente 9 caracteres
-- Nombre: contenido de tipo caracteres (máximo 10 caracteres). El campo Nombre deberá contener dos vocales iguales (mínimo). El campo Nombre deberá contener las letras “a” y “r”
-- Apellido: contenido de tipo caracteres (máximo 20 caracteres). El campo Apellido, deberá comenzar o terminar por la letra “s”. El campo Apellido deberá tener 8 caracteres (mínimo)
-- Dirección: contenido de tipo caracteres (máximo 100 caracteres). El campo Dirección deberá contener la palabra “avenida” o “calle”. El campo Dirección deberá contener la palabra “bloque” o “número”
-- Email: contenido de tipo caracteres (máximo 20 caracteres). El campo Email deberá con tener el símbolo “@”. El Email deberá ser “gmail” o ”hotmail”. El campo Email deberá con terminar por “.com” o “.es”
-- *Todos los campos podrán contener valores NULL, a excepción del DNI, Nombre e Email

create table vendedor(
dni varchar(9) primary key constraint chk_dni check(char_length(dni)=9),
nombre varchar(10) constraint chk_nombre check((nombre like "%a%a%" or nombre like "%e%e%" or nombre like "%i%i%" or nombre like "%o%o%" or nombre like "%u%u%") and (nombre like "%r%" and nombre like "%a%")),
apellido varchar(20) constraint chk_apellido check((apellido like "%s" or apellido like "s%") and char_length(apellido)>=8),
direccion varchar(100) constraint chk_dir check((direccion like "%avenida%" or direccion like "%calle%") and (direccion like "%bloque%" or direccion like "%numero%")),
email varchar(20) constraint chk_email check(email like "%@%" and (email like "%hotmail%" or email like "%gmail%") and (email like "%.com" or email like "%.es"))
);

-- Ejercicio 4.- Crea una tabla VENTA en la base de datos CONCESIONARIO añade las siguientes columnas:
-- ID_venta: identificador de tipo numérico (PK). El campo ID deberá ser un valor que incremente de forma automática y comience por el número 1
-- Coche:  identificador de tipo numérico
-- Empleado: identificador de tipo caracteres (máximo 9 caracteres). El campo DNI deberá tener exactamente 9 caracteres
-- Fecha_venta: contenido de tipo fecha. El campo Fecha_venta deberá tener tener un mes correspondiente a uno de los meses de verano
-- *Ninguno de los campos podrá contener valores NULL

create table venta(
id_venta int primary key auto_increment,
coche int not null,
empleado varchar(9) constraint chk_emp check(char_length(empleado)=9) not null,
fecha_venta date constraint chk_fecha check(month(fecha_venta) between 6 and 9) not null
);

-- Ejercicio 5.- Haz que la columna Coche de la tabla VENTA referencie como clave foránea a la PK de la tabla COCHE.

alter table venta add constraint fk_coche foreign key (coche) references coche(id);

-- Ejercicio 6.- Haz que la columna Empleado de la tabla VENTA referencie como clave foránea a la PK de la tabla EMPLEADO.

alter table venta add constraint fk_empleado foreign key (empleado) references vendedor(dni);

-- Ejercicios 7.- Inserta 3 filas de datos en cada una de las tablas y comprueba que los datos se han insertado correctamente.
