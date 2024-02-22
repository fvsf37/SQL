-- Ejercicio 1.- Crea una Tabla en MySQL con las siguientes columnas y sus correspondientes restricciones:
create database cesur2;
use cesur2;
create table usuario(
-- 	ID: identificador de tipo entero que se incremente automáticamente y comience por el número 50. PK
id int auto_increment primary key,

--  Nombre: contenido de tipo carácter (máximo 10 caracteres, mínimo 5). No puede ser nulo.
nombre varchar(10) constraint `chk_nombre` check(char_length(nombre) >= 5) not null,

--  Apellido: contenido de tipo carácter (máximo 10 caracteres) que no contenga más de 2 letras “s”
apellido varchar(10) constraint `chk_apellido` check(apellido not like '%s%s%'),

--  Altura: contenido de tipo decimal con 2 decimales y un entero. No puede ser nulo.
altura decimal(3,2) not null,

--  Edad: contenido de tipo entero (mayores de edad y menores de 64 años)
edad int constraint `chk_edad` check (edad > 17 and edad < 64),

--  Dirección: contenido de tipo carácter que contenga la palabra “calle” o “avenida” y los caracteres “n.º” o “Bloque”. Máximo 50 caracteres, mínimo 10. No puede ser nulo.
direccion varchar(50) constraint `chk_direccion` check((direccion like '%calle%' or direccion like '%avenida%') and (direccion like '%nº%' or direccion like '%bloque%') and char_length(direccion)>9) not null,

--  Genero: contenido con 3 valores posibles (Masculino, Femenino u Otros), por defecto “Otros”
genero enum('masculino', 'femenino', 'otros') default 'otros',

--  Fecha: contenido de tipo fecha (fechas que no estén contenidas en los meses de verano). No puede ser nulo.
fecha date constraint `chk_fecha` check(month(fecha) between 06 and 09) not null,

--  Email: contenido de tipo carácter que contenga el carácter “@” y ser de tipo “gmail” o “hotmail”
email varchar(20) constraint `chk_email` check(email like '%@%' and (email like '%email%' and email like '%hotmail%'))
)auto_increment = 50;

-- *Añade 3 filas de valores a las tablas anteriormente creadas. Añade solo los valores estrictamente necesarios para que el programa no muestre ningún error
insert into usuario(nombre, apellido, altura, direccion, fecha) values
('Manolo', 'asaa', 1.76, 'calle papa bloque 2', '2000-07-15');
select * from usuario;

-- Ejercicio 2.- Realiza las siguientes modificaciones en la tabla del ejercicio 1.
-- Modifica el nombre de la tabla
alter table usuario rename usuarios;

-- Modifica del nombre de la columna “email” a “correo”
alter table usuarios change column email correo varchar(20);

-- Modifica la restricción de la fecha para que permita valores de fechas contenidos en verano e invierno
alter table usuarios drop constraint `chk_fecha`,
add constraint `chk_fecha` check(month(fecha) in (1, 2, 6, 7, 8, 9, 12));

-- Modifica el atributo “altura” para que permita dos enteros con dos decimales
alter table usuarios modify column altura decimal(4,2);

-- Modifica el atributo apellido para que añada un valor por defecto
alter table usuarios modify column apellido varchar(10) default 'apellido';

-- Añade el carácter “m” en el contenido de la altura (ejemplo, 1.90m)
alter table usuarios modify altura varchar(10); 
update usuarios set altura = concat(altura,'m');

-- Modifica el atributo Edad para que permita valores mayores de 65
alter table usuario drop constraint `chk_edad`;
alter table usuario modify column edad int constraint `chk_edad` check(edad>17 and edad< 66);

-- Modifica el valor de género para que aparezca Femenino por defecto
alter table usuarios modify column genero enum('masculino', 'femenino', 'otros') default 'femenino';

-- Elimina todos los registros que contengan un email de tipo “hotmail”
delete from usuarios where email like '%hotmail%';

-- Elimina todos los registros que contengan género Masculino
delete from usuarios where genero like '%masculino%';

-- Elimina la columna ID
alter table usuarios drop column id;

-- Elimina la tabla del ejercicio 1
drop table usuarios;