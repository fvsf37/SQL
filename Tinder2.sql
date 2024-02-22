create database tinder;
use tinder;

create table usuarios(
id int auto_increment primary key,
nombre varchar(15) not null constraint chk_nombre
check(char_length(nombre) between 4 and 8),
apellido varchar(20) constraint chk_apellido
check((apellido like "%s" or apellido like "%z") and apellido <> "Rodriguez"),
edad int not null constraint chk_edad check(edad between 18 and 99),
orientacion enum ("Heterosexual", "Homosexual", "Otro") default "Otro"
)auto_increment=20;

create table likes(
id int auto_increment primary key,
fecha date not null constraint chk_fecha check(month(fecha) in (1, 3, 5, 7, 9, 11)),
tipo enum("like", "superlike") default "like",
usuario1 int not null,
usuario2 int not null
)auto_increment=101;

alter table likes add constraint fk_u1 foreign key (usuario1) references usuarios(id);
alter table likes add constraint fk_u2 foreign key (usuario2) references usuarios(id);

insert into usuarios (nombre, apellido, edad, orientacion) values
("Paco", "Fernandez", 35, "homosexual"),
("Aida", "Ruiz", 39, "heterosexual"),
("Carla", "Alvarez", 40, "otro"),
("Luciaa", "Campos", 20, "homosexual"),
("Juncal", "Calvos", 40, "otro");

insert into likes (fecha, tipo, usuario1, usuario2) values
("2020-11-28", "like", 23, 21),
("2019-07-07", "like", 21, 22),
("2021-09-02", "superlike",24, 20),
("2022-03-22", "superlike",21, 24),
("2020-01-10", "like",20, 24);

 
-- Ejercicio 1.- Modifica la restricción de nombre de la tabla Usuarios para que también acepte nombres que tenga desde 10 a 15 caracteres (ambos no incluidos).
alter table usuarios drop constraint chk_nombre;
alter table usuarios add constraint chk_nombre check((char_length(nombre) between 4 and 8) or (char_length(nombre) between 11 and 14));

-- Ejercicio 2.- Añade una nueva columna en la tabla Usuarios de nombre Apodo que por defecto contenga el valor “X”, y contenga más de 3 caracteres, o una letra X.
alter table usuarios add column apodo varchar(15) default "x" constraint chk_apodo check(apodo like "%x%" or char_length(apodo)>3);

-- Ejercicio 3.- Modifica el valor tipo de la tabla Likes para que pueda contener valores NULL.
alter table likes modify tipo enum("like", "superlike");

-- Ejercicio 4.- Modifica el nombre de las columnas Usuario1 y Usuario2 para que se llamen Emisor y Receptor respectivamente, y sigan siendo claves foraneas.
alter table likes drop foreign key fk_u1;
alter table likes rename column Usuario1 to emisor;
alter table likes drop foreign key fk_u2;
alter table likes rename column Usuario2 to receptor;
alter table likes add constraint fk_u1 foreign key (emisor) references usuarios(id);
alter table likes add constraint fk_u2 foreign key (receptor) references usuarios(id);

-- Ejercicio 5.- Modifica el valor de la orientación para que contenga “otros” en vez de “otro”. A partir de ahora la orientación permitirá los valores Homosexual, Heterosexual y Otros.
alter table usuarios modify orientacion enum ("Heterosexual", "Homosexual", "Otro", "otros") default "Otro";
update usuarios set orientacion="otros" where orientacion="otro";
alter table usuarios modify orientacion enum ("Heterosexual", "Homosexual", "otros") default "Otros";

-- Ejercicio 6.- Inserta el siguiente registro en la tabla Likes sin que el programa de ningún error.
-- Fecha: 2021-06-18
-- Tipo: Hiperlike
-- Emisor: 45
-- Receptor: 22
alter table likes modify tipo enum("like", "superlike", "Hiperlike") default "like";
alter table likes drop constraint chk_fecha;
alter table likes drop foreign key fk_u1;
insert into likes (fecha, tipo, emisor, receptor) values 
("2021-06-18", "Hiperlike", 45, 22);

-- Ejercicio 7.- Modifica el valor de la edad, dividiéndola entre 3, siempre y cuando el valor de la orientación sea distinta a “homosexual”. Realiza las modificaciones necesarias para que no se pierdan registros (decimales) durante la operación.
alter table usuarios drop constraint chk_edad;
alter table usuarios modify edad decimal(6,3);
update usuarios set edad=edad/3 where orientacion<>"homosexual";

-- Ejercicio 8.- Modifica el Apodo de los usuarios con orientación “heterosexual” añadiéndoles el número 0.
update usuarios set apodo=concat(apodo, "0") where orientacion="heterosexual";

-- Ejercicio 9.- Elimina los registros de tipo “like” que se haya realizado en un mes menor que el mes de la fecha en la que se realizo el primer “like”. Es decir, obtén la fecha en la que se realizo en primer “like” de la base de datos, y elimina los registros de tipo “like” que se hayan realizado en un mes anterior (menor) al mes de la fecha obtenida anteriormente.
delete from likes where tipo="like" and month(fecha)< (select month(fecha) from likes where tipo="like" order by fecha limit 1);

-- Ejercicio 10.- Elimina la tabla Usuarios de la base de datos Tinder.
alter table likes drop foreign key fk_u2;
drop table usuarios;