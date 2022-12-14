DROP database IF EXISTS partediario;
CREATE DATABASE partediario;
USE partediario;

DROP TABLE if exists InasistenciaAlumno;
DROP TABLE if exists Alumno;
DROP TABLE IF EXISTS Observaciones;
DROP TABLE if exists AsistenciaProfesor;
DROP TABLE if exists Curso;
DROP TABLE if exists Profesor;
DROP TABLE if exists EspacioCurricular;
DROP TABLE if exists Horarios;
DROP TABLE if exists Titularidad;


CREATE TABLE Curso (
id int auto_increment not null ,
año int not null,
division int not null,
ciclolectivo int not null,
primary key (id)
); 

ALTER TABLE Curso ADD UNIQUE (año, division, ciclolectivo);

CREATE TABLE Parte (
fecha date not null,
curso int not null,
FOREIGN KEY (curso) REFERENCES Curso(id),
PRIMARY KEY (fecha, curso)
);

CREATE TABLE Alumno (
dni int not null,
apellido varchar (255) not null,
nombre varchar(255) not null,
curso_key int not null,
foreign key (curso_key) references Curso(id),
primary key (dni)
);

CREATE TABLE InasistenciaAlumno (
fecha date not null,
alumno int not null,
inasistenciaTmañana boolean,
inasistenciaTtarde boolean,
tardanzaTmañana datetime,
tardanzaTtarde datetime,
curso int not null,
foreign key (alumno) references Alumno(dni),
foreign key (fecha) references Parte(fecha),
foreign key (curso) references Parte (curso),
primary key (alumno, fecha, curso)
);

CREATE TABLE EspacioCurricular (
id int auto_increment not null,
materia varchar(255) not null,
curso_key int not null,
FOREIGN KEY (curso_key) REFERENCES Curso(id),
PRIMARY KEY (id)
);

ALTER TABLE EspacioCurricular ADD UNIQUE (materia, curso_key);

CREATE TABLE Profesor (
dni int not null,
apellido varchar(255) not null,
nombre varchar(255) not null,
primary key (dni)
);

CREATE TABLE Observaciones (
id int auto_increment not null,
alumno varchar(255) not null,
fecha date not null,
comunicado varchar(255) not null,
profesor_key int not null,
espaciocurricular_key int not null,
curso int not null,
Foreign key (profesor_key) references Profesor(dni),
Foreign key (espaciocurricular_key) references EspacioCurricular(id),
foreign key (fecha) references Parte(fecha),
foreign key (curso) references Parte (curso),
primary key (id)
);

CREATE TABLE Horarios (
id int auto_increment not null,
espaciocurricular_key int not null,
dia int not null,
hora int not null,
foreign key (espaciocurricular_key) references EspacioCurricular(id),
primary key (id)
);

CREATE TABLE Titularidad (
profesor int not null,
espaciocurricular_key int not null,
titular boolean not null,
foreign key (profesor) references Profesor(dni),
foreign key (espaciocurricular_key) references EspacioCurricular(id),
primary key (profesor, espaciocurricular_key)
);

CREATE TABLE AsistenciaProfesor (
fecha date not null,
hora_key int not null,
profesor_key int not null,
espaciocurricular_key int not null,
curso int not null,
Foreign key (hora_key) references Horarios(id),
Foreign key (profesor_key) references titularidad(profesor),
Foreign key (espaciocurricular_key) references espaciocurricular(id),
foreign key (fecha) references Parte(fecha),
foreign key (curso) references Parte (curso),
primary key (fecha, curso, hora_key)
);

ALTER TABLE AsistenciaProfesor ADD UNIQUE (fecha, hora_key, profesor_key);
-- NO PUEDE ASISTIR UN MISMO PROFESOR A MATERIAS DISTINTAS EN LA MISMA HORA

