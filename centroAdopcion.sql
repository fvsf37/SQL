create database centroadopcion;
use centroadopcion;

create table perros(
id int primary key,
nombre varchar(20),
edad int,
altura decimal(3,2),
raza varchar(20),
color enum('marron','gris','blanco'),
fecha_nac date
);

create table humanos(
dni varchar(9) primary key,
nombre varchar(20),
apellido varchar(20),
n_cuenta varchar(20),
edad int,
sexo enum('f','m')
);

alter table humanos add column perrito int,
add constraint `fk_perrito` foreign key (perrito) references perros(id);

INSERT INTO perros (ID, NOMBRE, EDAD, ALTURA, RAZA, COLOR, FECHA_NAC) VALUES
(1, 'Toby', 1, 0.65, 'Bulldog', 'Marrón', '2018-10-10'),
(2, 'Taco', 5, 1.2, 'Pastor alemán', 'Gris', '2015-01-12'),
(3, 'Mambo', 12, 2.05, 'Galgo', 'Blanco', '2007-03-03'),
(4, 'Rulo', 3, 0.85, 'Labrador', 'Gris', '2016-12-25'),
(5, 'Gordo', 6, 1.6, 'Chihuahua', 'Marrón', '2014-05-05');

INSERT INTO humanos (DNI, NOMBRE, APELLIDO, N_CUENTA, EDAD, SEXO)
VALUES
('44566880R', 'Jon', 'Zamora', '12345678', 22, 'M'),
('12300200M', 'Nuria', 'Lester', '49213572', 35, 'F'),
('42424242P', 'Aitor', 'Ramiro', '67356870', 43, 'M'),
('12345678L', 'Maria', 'Jimenez', '68806005', 19, 'F');

select * from perros;
select * from humanos;

alter table perros modify fecha_nac varchar(50);
insert into perros(id, nombre, edad, altura, raza, color, fecha_nac) values
(25, 'timmy', '3', '1.85', 'shar pei', 'marron', '12 de octubre de 2016');
alter table perros add column estado enum('adiestrado', 'salvaje');

update perros set estado = 'salvaje' where id<=4;
update perros set estado = 'adiestrado' where id>4;


alter table perros modify column altura decimal(6,2);
update perros set altura = altura / 100;

update perros set edad = edad * 12;

update humanos set nombre = concat('Sr', nombre) where sexo = 'm';
update humanos set nombre = concat('Sra', nombre) where sexo = 'f';

alter table humanos modify column sexo enum('masculino', 'femenino', 'm', 'f');
update humanos set sexo = 'masculino' where sexo = 'm';
update humanos set sexo = 'femenino' where sexo = 'f';


alter table humanos rename column edad to años;

alter table humanos modify column n_cuenta varchar(27);

alter table perros modify column id int not null;
alter table humanos modify column dni varchar(9) not null primary key;


delete from perros where edad > 80;

delete from humanos where edad < 30;

alter table humanos drop column años;

alter table humanos drop constraint `fk_perrito`;

alter table humanos drop table humnaos;

delete

