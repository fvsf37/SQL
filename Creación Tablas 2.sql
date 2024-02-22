create database AFUERA_BD;
use AFUERA_BD;
CREATE TABLE ALUMNOS(
	dni varchar(9) primary key,
    nombre varchar(30),
    edad decimal(2,0) not null,
    direccion varchar(50),
    fecha_nacimiento date default "2001-10-10"
);

CREATE TABLE PROFESORES(
	ID int auto_increment primary key,
    nombre varchar(30) not null,
    hora_entrada time default "00:00:00",
	hora_salida time default "00:00:00",
    contrato enum ("Fijo", "Temporal", "Practicas")    
);

CREATE TABLE NOTAS(
	codigo int primary key,
    media decimal(4,2) not null,
    profesor int not null,
    alumno varchar(9) not null
);

alter table notas add constraint `FK_PROFESORES` 
foreign key (profesor) references profesores(id);

alter table notas add constraint `FK_ALUMNOS` 
foreign key (alumnos) references alumnos(dni);

INSERT INTO ALUMNOS (DNI, Nombre, Edad, Dirección, Fecha_nacimiento) VALUES
('123456789', 'Juan Pérez', 20, 'Calle A', '2000-01-15'),
('987654321', 'María Gómez', 22, 'Calle B', '1999-05-20'),
('111223344', 'Pedro Ramírez', 19, 'Calle C', '2002-03-10');

INSERT INTO PROFESORES (Nombre, Hora_entrada, Hora_salida, Contrato) VALUES
('Profesor A', '08:00:00', '16:00:00', 'Fijo'),
('Profesor B', '09:00:00', '17:00:00', 'Temporal'),
('Profesor C', '10:00:00', '18:00:00', 'Prácticas');

INSERT INTO NOTAS (Código, Media, Profesor, Alumno) VALUES
(1, 8.5, 1, '123456789'),
(2, 7.2, 2, '987654321'),
(3, 9.0, 3, '111223344');