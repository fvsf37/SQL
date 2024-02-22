create database tienda;

use tienda;

create table EMPLEADO(
    DNI VARCHAR(9) PRIMARY KEY,
    NOMBRE VARCHAR(10) NOT NULL,
    APELLIDO VARCHAR(20),
    ALTURA DECIMAL(3,2),
    GENERO ENUM ("Masculino", "Femenino", "Otro") default "Otro",
    HORA_FICHAJE TIME
);

CREATE TABLE PRODUCTO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(15) DEFAULT "Desconocido" NOT NULL,
    PRECIO DECIMAL(4,1),
    PESO DECIMAL(3,0),
    TIPO ENUM ("Electronica", "Moda", "Decoracion"),
    FECHA_CADUCIDAD DATE NOT NULL,
    ENCARGADO VARCHAR(9)
);

ALTER TABLE PRODUCTO add CONSTRAINT `FK_EMPLEADO` 
FOREIGN KEY (ENCARGADO) REFERENCES EMPLEADO(dni);

insert into EMPLEADO (DNI, NOMBRE, APELLIDO, ALTURA, GENERO, HORA_FICHAJE) VALUES
("12345w", "ANGEL", "MORENO", 4.24, "Femenino", "20:00:00"),
("22352t", "JUANMA", "BLANCO", 1.10, "Masculino", "00:30:01"),
("21111r", "ADRIAN", "JIMENEZ", 2.05, "Otro", "11:42:21");

insert into PRODUCTO (NOMBRE, PRECIO, PESO, TIPO, FECHA_CADUCIDAD, ENCARGADO) VALUES
("TELEFONO", 250.0, 100, "Electronica", "2024-02-20", "12345w"),
("ABRIGO", 560.9, 550, "Moda", "2026-12-26", "12345w"),
("LAMPARA", 60.8, 52, "Decoracion", "2030-12-12", "21111r");
